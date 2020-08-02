      * CSCI3180 Principles of Programming Languages ∗
      * --- Declaration --- ∗
      * I declare that the assignment here submitted is original except for source
      * material explicitly acknowledged. I also acknowledge that I am aware of
      * University policy and regulations on honesty in academic work, and of the
      * disciplinary guidelines and procedures applicable to breaches of such policy
      * and regulations, as contained in the website
      * http://www.cuhk.edu.hk/policy/academichonesty/ ∗
      * Assignment 1
      * Name : Zhang Xin Yu
      * Student ID : 1155091989
      * Email Addr : xyzhang7@cse.cuhk.edu.hk 
      
       identification division.
       program-id. ta-ranking.

       environment division.
       input-output section.
       file-control.
           select ins 
           assign to "/media/sf_CS318/ta_ranking/instructors.txt"
           organization is line sequential
           file status is course-status.

           select can 
           assign to "/media/sf_CS318/ta_ranking/candidates.txt"
           organization is line sequential
           file status is ta-status.

           select summ
           assign to 'output.txt'
           organization is line sequential.
           

       data division.
       file section.

       fd ins.
       01 courses.
           03 course-id pic 9(4).
           *> seperation
           03 se pic x.
           03 required-skills occurs 3 times.
               05 c-r-skill pic x(15).
           03 optional-skills occurs 5 times.
               05 c-o-skill pic x(15).

       fd can.
       01 tas.
           03 ta-id pic 9(10).
           03 se pic x.
           03 skills occurs 8 times.
               05 ta-skill pic x(15).
           03 prefer-courses occurs 3 times.
               05 prefer-course pic 9(4).
               05 se2 pic x.

       fd summ.
       01  scores.
           05 o-course-id pic 9(4).
           05 o-se0 pic x.
           05 o-ta1-id pic 9(10).
           05 o-se1 pic x.
           05 o-ta2-id pic 9(10).
           05 o-se2 pic x.
           05 o-ta3-id pic 9(10).
           05 o-se3 pic x.
           *>05 score-eol pic x.


       working-storage section. 

      * c-record: number of records in instructors.txt file
       77 c-record pic 9(10) value 0. 

      * sa: number of satisfied required skills
       77 sa pic 9 value 0.

      * i, j, m, n iteration number 
       77 i pic 9 value 0.
       77 j pic 9 value 0.
       77 m pic 9 value 0.
       77 n pic 9 value 0. 

      * score: total score
      * s-score: skill score
      * o-score: optional score
       77 s-score pic 9 value 0.
       77 o-score pic 9v9 value 0.
       77 score pic 9v9 value 0.
       
      * instructor
       01 ws-courses.
           03 ws-course-id pic 9(4).
           03 ws-se pic x.
           03 ws-required-skills occurs 3 times.
               05 ws-c-r-skill pic x(15).
           03 ws-optional-skills occurs 5 times.
               05 ws-c-o-skill pic x(15).
       01 rank-ta. 
           03 ws-ta1-id pic 9(10).
           03 ws-ta1-score pic 9v9 value 0.
           03 ws-ta2-id pic 9(10).
           03 ws-ta2-score pic 9v9 value 0.
           03 ws-ta3-id pic 9(10).
           03 ws-ta3-score pic 9v9 value 0.
       01 course-status pic xx.
       01 course-count pic 9(10) value 0.

      * ta
       01 ws-tas.
           03 ws-ta-id pic 9(10).
           03 ws-se pic x.
           03 ws-skills occurs 8 times.
               05 ws-ta-skill pic x(15).
           03 ws-prefer-courses occurs 3 times.
               05 ws-prefer-course pic 9(4).
               05 ws-se2 pic x.
       01 ta-status pic xx. 
       01 ta-count pic 9(10) value 0.

       procedure division.
       prog-main.
           open input ins.      
      * instructos.txt file not exists
               if course-status = 35
                   display "non-existing file"
                   close ins
                   stop run
               end-if.
           close ins.
           open input can.          
      * candidates.txt file not exists
               if ta-status = 35 
                   display "non-existing file"
                   close can 
                   stop run
               end-if.            
           close can.           

           open input ins.      
      * empty instructors.txt
               perform empty-ins.
               if c-record = 0
                   display "empty file"
                   open output summ
                   close summ
                   close ins
                   stop run
               end-if.  
           close ins.
           

      * read instructor.txt file     
           open input ins.
           open output summ.
           perform read-ins.
           close ins.
           close summ.
           stop run.


       empty-ins.
           *>display "course-status: " course-status.
           read ins
           not at end 
           add 1 to c-record
           end-read.


       read-ins. 
           *>display "before read ins status: " course-status.
           read ins into ws-courses.
           *>display "after read ins status: "course-status.
           if course-status not = 10
               display "course: " ws-course-id
               
      * initialize rank-ta
               move 0 to ws-ta1-score
               move 0 to ws-ta2-score 
               move 0 to ws-ta3-score
               move 0000000000 to ws-ta1-id
               move 0000000000 to ws-ta2-id
               move 0000000000 to ws-ta3-id
               
      * initialize output file
               move ws-course-id to o-course-id
               move ' ' to o-se0
               move ' ' to o-se1
               move ' ' to o-se2
               move ' ' to o-se3
               *>move x'0d' to score-eol

      * read candidates file 
               open input can
               perform read-can
               close can

      * write rank ta id
               move ws-ta1-id to o-ta1-id
               move ws-ta2-id to o-ta2-id
               move ws-ta3-id to o-ta3-id 
               write scores
               end-write 

      * loop instructors
               display "-----------------------------------------------"
               perform read-ins
           end-if. 
           

       read-can.
           read can into ws-tas.
           *>display "ws-tas:" ws-tas.
           if ta-status not = 10
               display "ta: " ws-ta-id
               perform check-sa
               
               if score = 1
                   perform cal-skill-score
                   perform cal-prefer-score
                   add s-score to score
                   add o-score to score
                   display "score: " score
                   perform rank-ta-score
                   
               end-if
            
      * loop candidates
               move 0 to score
               perform read-can 
           end-if.


      * check whether all the required skills are satisfied
       check-sa.
           move 1 to i. 
           move 1 to j.
           move 0 to sa.
           perform check-sa-ite.                  

    
      * iterational function to check satisfied skills
       check-sa-ite.
           if ws-ta-skill(i) = ws-c-r-skill(j)
               add 1 to sa          
           end-if.
           *>display "i " i " j " j.
           *>display "ta " ws-ta-skill(i) " cr " ws-c-r-skill(j) " sa " sa.

           if ( i = 8 and j = 3 ) or ( i = 8 and j > sa )
               *>display "end check"
               if sa >= 3
                   move 1 to score 
               end-if
           end-if.

           if i = 8 and j < 3 and j = sa
               move 1 to i 
               add 1 to j
               perform check-sa-ite
           end-if.

           if i < 8 and j <= 3
               add 1 to i 
               perform check-sa-ite
           end-if.


      * calculate skill score
       cal-skill-score.
           move 1 to m.
           move 1 to n.
           move 0 to s-score.
           perform cal-skill-score-ite.


      * iterational function to calculate skill score
       cal-skill-score-ite.
           if ws-ta-skill(m) = ws-c-o-skill(n)
               add 1 to s-score
           end-if. 

           if m = 8 and n < 5
               move 1 to m     
               add 1 to n 
               perform CAL-SKILL-SCORE-ITE
           end-if. 
           
           if m < 8 and n <= 5
               add 1 to m  
               perform CAL-SKILL-SCORE-ITE
           end-if. 


      * calculate preference score 
       cal-prefer-score.
           move 1 to m.
           move 1 to n.
           move 0 to o-score.

           if ws-course-id = ws-prefer-course(1)
               move 1.5 to o-score 
           end-if.

           if ws-course-id = ws-prefer-course(2)
               move 1.0 to o-score 
           end-if.

           if ws-course-id = ws-prefer-course(3)
               move 0.5 to o-score 
           end-if.
               
           *>display "prefer score: " o-score.


      * rank ta score
       rank-ta-score.
           if (score > ws-ta1-score) or 
              (score = ws-ta1-score and ws-ta-id < ws-ta1-id) 
               move ws-ta2-score to ws-ta3-score 
               move ws-ta2-id to ws-ta3-id 
               move ws-ta1-score to ws-ta2-score 
               move ws-ta1-id to ws-ta2-id
               move score to ws-ta1-score
               move ws-ta-id to ws-ta1-id
           end-if.
           
           if (score < ws-ta1-score and score > ws-ta2-score) or 
              (score = ws-ta1-score 
                   and ws-ta-id > ws-ta1-id 
                   and ws-ta-id < ws-ta2-id ) or
              (score = ws-ta2-score 
                   and ws-ta-id < ws-ta2-id)
               move ws-ta2-score to ws-ta3-score 
               move ws-ta2-id to ws-ta3-id 
               move score to ws-ta2-score
               move ws-ta-id to ws-ta2-id
           end-if.

           if (score < ws-ta2-score and score > ws-ta3-score) or
              (score = ws-ta2-score 
                   and ws-ta-id > ws-ta2-id  
                   and ws-ta-id < ws-ta3-id) or 
              (score = ws-ta3-score 
                   and ws-ta-id < ws-ta3-id)
               move score to ws-ta3-score
               move ws-ta-id to ws-ta3-id
           end-if.

           
                          
           
           
           
               