# Author NING Jingjie, Ethan, the Chinese University of Hong Kong

from random import choice

# program setting, number of lines in each file
number_of_candidates = 0
number_of_instructors = 0

list_of_skills = ["C", "C++", "Java", "Python", "COBOL", "Fortran", "TCP IP", "Java Script", "Open Source",
                  "Front End", "Back End", "NLP", "Neural Network", "CV", "CG", "Games", "Dancing",
                  "Biking", "Music", "Photography"]


def fixed_length_number(length):
    return choice(range(10 ** (length - 1), 10 ** length - 1))


def generate_candidates():
    current_sid = "1155" + str(fixed_length_number(6))
    while current_sid in list_of_SID:
        current_sid = "1155" + str(fixed_length_number(6))

    list_of_SID.append(current_sid)

    skills = list()
    skills_cnt = 0

    while True:
        current_skill = choice(list_of_skills)
        if current_skill not in skills:
            skills.append(current_skill)
            skills_cnt += 1
        if skills_cnt == 8:
            break

    preferences = list()
    preferences_cnt = 0

    while True:
        current_perference = choice(list_of_CID)
        if current_perference not in preferences:
            preferences.append(current_perference)
            preferences_cnt += 1
        if preferences_cnt == 3:
            break

    dict_of_candidates[current_sid] = (current_sid.ljust(11)
                                       + skills[0].ljust(15)
                                       + skills[1].ljust(15)
                                       + skills[2].ljust(15)
                                       + skills[3].ljust(15)
                                       + skills[4].ljust(15)
                                       + skills[5].ljust(15)
                                       + skills[6].ljust(15)
                                       + skills[7].ljust(15)
                                       + preferences[0].ljust(5)
                                       + preferences[1].ljust(5)
                                       + preferences[2].ljust(5)
                                       + "\n")


def generate_instructors():
    current_cid = str(fixed_length_number(4))
    while current_cid in list_of_CID:
        current_cid = str(fixed_length_number(4))

    list_of_CID.append(current_cid)

    skills = list()
    skills_cnt = 0

    while True:
        current_skill = choice(list_of_skills)
        if current_skill not in skills:
            skills.append(current_skill)
            skills_cnt += 1
        if skills_cnt == 8:
            break

    dict_of_instructors[current_cid] = (current_cid.ljust(5)
                                        + skills[0].ljust(15)
                                        + skills[1].ljust(15)
                                        + skills[2].ljust(15)
                                        + skills[3].ljust(15)
                                        + skills[4].ljust(15)
                                        + skills[5].ljust(15)
                                        + skills[6].ljust(15)
                                        + skills[7].ljust(15)
                                        + "\n")


if __name__ == '__main__':
    if len(list_of_skills) < 8:
        print("There Must be at least eight skills!\n")
        exit(0)

    # list for deduplication
    list_of_SID = list()
    list_of_CID = ["1001", "1002", "1003"]
    # Making sure that the preference list is non-empty no matter how many actual courses are to be generated.

    dict_of_candidates = dict()
    dict_of_instructors = dict()

    for i in range(number_of_instructors):
        generate_instructors()

    for i in range(number_of_candidates):
        generate_candidates()

    can_file = open('candidates.txt', 'w')
    ins_file = open('instructors.txt', 'w')

    for key in sorted(dict_of_candidates):
        can_file.write(dict_of_candidates[key])

    for key in sorted(dict_of_instructors):
        ins_file.write(dict_of_instructors[key])

    can_file.close()
    ins_file.close()