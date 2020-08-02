/*
∗ CSCI3180 Principles of Programming Languages ∗
∗ --- Declaration --- ∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
∗ Assignment 1
∗ Name : Zhang Xin Yu
∗ Student ID : 1155091989
∗ Email Addr : xyzhang7@cse.cuhk.edu.hk
*/

#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <string.h>
#include <inttypes.h>

//convert a char string into int
int digit_id(char *s){
    //printf("s: %s, size: %lu\n", s, strlen(s));
    int i;
    for(i=0; i<strlen(s); i++){
        if(!isdigit(s[i])){
            printf("input: %s, expect a digit input\n", s);
            return 0;
        }
    }
    int num = atoi(s);
    return num;
}

//check if all the required skills are satisfied
int fulfill(char required_skills[3][16], char ta_skills[8][16]){
    int i, j;
    for(i=0; i<3; i++){
        for(j=0; j<8; j++){
            int rt = strcmp(required_skills[i], ta_skills[j]);
            //printf("compare: %s, %s, rt:%d\n",required_skills[i], ta_skills[j], rt);
            if( rt == 0){
                break;
            }else if(j==7){
                return 0;
            }
        }
    }
    return 1;
}

//calculate score
float cal_score(char optional_skills[5][16], char ta_skills[8][16], int course, int prefer_courses[3]){
    float score = 1;
    int i, j;
    for(i=0; i<5; i++){
        for(j=0; j<8; j++){
            int rt = strcmp(optional_skills[i], ta_skills[j]);
            if( rt == 0){
                score = score + 1; break;
            }
        }
    }
    for(i=0; i<3; i++){
        if(course == prefer_courses[i]){
            switch (i) {
                case 0:
                    score += 1.5;
                    break;
                case 1:
                    score += 1;
                    break;
                case 2:
                    score += 0.5;
                    break;
                default:
                    break;
            }
            break;
        }
    }
    return score;
}

int main(int argc, const char * argv[]) {
    //initialize data
    int course = 0;
    char required_skills[3][16] = {{0}};
    char optional_skills[5][16] = {{0}};
    
    int ta_id = 0;
    char ta_skills[8][16] = {{0}};
    int prefer_courses[3] = {0};
    
    float score[3] = {0};
    int rank_id[3] = {0};
    
    char str[200];
    char strc[200];
    char ch;
    int i, j;
    
    //check if file exists
    if( (access("instructors.txt", F_OK)) !=-1){
        //file exists
    }else{
        printf("non-existing file\n");
        exit(0);
    }
    
    if( (access("candidates.txt", F_OK)) !=-1){
        //file exists
    }else{
        printf("non-existing file\n");
        exit(0);
    }
    
    //open instructors file
    FILE *fp = fopen("instructors.txt", "r");
    if(fp == NULL){
        perror("unable to open file");
        exit(0);
    }
    
    //if instructors file is empty
    //create empty output file
    FILE *fptr;
    fptr = fopen("output.txt", "w");
    if(fptr ==NULL){
        printf("Error");
        exit(0);
    }
    fclose(fptr);
    
    ch = fgetc(fp);
    if(ch == EOF){
        exit(0);
    }
    fclose(fp);
    
    fp = fopen("instructors.txt", "r");
    fptr = fopen("output.txt", "w");

    
    //read instructors file
    while(fgets(str, 200, fp) != NULL){
        //printf("str: %s\n", str);
        //initialize data
        course = 0;
        for(i=0; i<3; i++){
            required_skills[i][0] = '\0';
        }
        for(i=0; i<5; i++){
            optional_skills[i][0] = '\0';
        }
       
        //read course id
        char course_id[5];
        strncpy(course_id, str, 4);
        course_id[4] = '\0';
        course = digit_id(course_id);
        printf("course: %d\n", course);
        
        //read required skills and optional skills for each course
        int ix = 5;
        for(i=0; i<8;i++){
            if(i<3){
                strncpy(required_skills[i], str+ix, 15);
                required_skills[i][15] = '\0';
            }else{
                strncpy(optional_skills[i-3], str+ix, 15);
                optional_skills[i-3][15] = '\0';
            }
            ix += 15;
        }
        
        //write course id in output file
        fprintf(fptr, "%d ", course);
        
        //open candidates file
        FILE *fpc = fopen("candidates.txt", "r");
        if(fpc == NULL){
            perror("Unable to open file");
            exit(0);
        }
        
        ch = fgetc(fpc);
        if(ch == EOF){
        //empty candidates file
            for(j=0; j<3; j++){
                fprintf(fptr, "0000000000 ");
            }
            fprintf(fptr, "\n");
        }else{
        //not empty candidates file
            fclose(fpc);
            fpc = fopen("candidates.txt", "r");
            
            //initialize data
            for(i=0; i<3; i++){
                rank_id[i] = 0;
                score[i] = 0;
            }
            
            while(fgets(strc, 200, fpc) != NULL){
                
                ta_id = 0;
                for(i=0; i<3; i++){
                    prefer_courses[i] = 0;
                }
                for(i=0; i<8; i++){
                    ta_skills[i][0] = '\0';
                }
                
                char ta_ID[11] = {0};
                strncpy(ta_ID, strc, 10);
                ta_ID[10] = '\0';
                ta_id = digit_id(ta_ID);
                
                int ix = 11;
                for(i=0; i<8; i++){
                    strncpy(ta_skills[i], strc+ix, 15);
                    ta_skills[i][15] = '\0';
                    ix += 15;
                }
                
                for(i=0; i<3; i++){
                    char prefer[5] = {0};
                    strncpy(prefer, strc+ix, 4);
                    prefer[4] = '\0';
                    prefer_courses[i] = digit_id(prefer);
                    ix += 5;
                }
                
                //calculate matching score for each candidates
                int ful = fulfill(required_skills, ta_skills);
                if(ful == 1){
                    float rank_score = 1;
                    rank_score += cal_score(optional_skills, ta_skills, course, prefer_courses);
                    
                //rank ta id by ranking score
                    if( (rank_score > score[0]) || (rank_score == score[0] && ta_id<rank_id[0]) ){
                        
                        score[2] = score[1];
                        score[1] = score[0];
                        score[0] = rank_score;
                        
                        rank_id[2] = rank_id[1];
                        rank_id[1] = rank_id[0];
                        rank_id[0] = ta_id;
                    }
                    
                    if( (rank_score > score[1] && rank_score < score [0]) || (rank_score == score[0] && ta_id > rank_id[0] && ta_id < rank_id[1]) || (rank_score == score[1] && ta_id < rank_id[1])){
                        
                        score[2] = score[1];
                        score[1] = rank_score;
                        
                        rank_id[2] = rank_id[1];
                        rank_id[1] = ta_id;
                    }
                    
                    if( (rank_score > score[2] && rank_score < score[1]) || (rank_score == score[1] && ta_id > rank_id[1] && ta_id < rank_id[2]) || (rank_score == score[2] && ta_id < rank_id[2]) ){
                        
                        score[2] = rank_score;
                        rank_id[2] = ta_id;
                    }
                }
                
            }
            for(j=0; j<3; j++){
                fprintf(fptr, "%010d ", rank_id[j]);
            }
            fprintf(fptr, "\n");
        }
        
        fclose(fpc);
        
    }
    fclose(fp);
    fclose(fptr);
    return 0;
}

