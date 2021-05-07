'''
This script will help you to check your verilog module file
It can find out all of the pre-used variables which means it was referenced before defined
And it can check the whole folder at one time,but only .v files are aimed for
When it finds these variables,it will tell you where they are,guiding you to correct them 
'''
import os
import re

#--------------------------------------------------------------------
#Change HERE to change the file folder you want to check
mod_file_path = r"F:\本科毕设相关\源代码\rtl"
#--------------------------------------------------------------------

def a_in_b(a,b):
    '''
    This function will judge whether a specified variable is in a string line
    @a: given variable string
    @b: given string line
    '''
    temp = ""
    if a not in b:
        return False
    else:
        lst = b.split(a)
        to_delete = []
        for i in range(len(lst)):
            if len(lst[i]) == 0:
                to_delete.append(i)

        for i in range(len(to_delete)):
            lst = lst.pop(to_delete[i])

        for i in range(len(lst)-1):
            lstr = lst[i]
            rstr = lst[i+1]

            if not (re.match("^[A-Za-z0-9_-]*$",lstr[-1])):
                if not (re.match("^[A-Za-z0-9_-]*$",rstr[0])):
                    return True
        return False


def extract_var(string):
    '''
    This function extracts all variable in a string line,
    on the condition that the line is a defining line to define reg/wire(s)
    And it will return the variables in a list
    @string: given string line
    '''
    lst = []
    lst = string.split(",")
    for i in range(len(lst)):
        lst[i] = lst[i].lstrip().lstrip(";").lstrip()
        lst[i] = lst[i].rstrip().rstrip(";").rstrip()
        if "]" in lst[i]:
            sub_lst = lst[i].split("]")
            lst[i] = sub_lst[-1].lstrip().lstrip(";").lstrip()
            lst[i] = lst[i].rstrip().rstrip(";").rstrip()
        if " " in lst[i]:
            sub_lst = lst[i].split(" ")
            lst[i] = sub_lst[-1].lstrip().lstrip(";").lstrip()
            lst[i] = lst[i].rstrip().rstrip(";").rstrip()

    to_delete = []
    for i in range(len(lst)):
        if len(lst[i]) == 0:
            to_delete.append(i)
            
    for i in range(len(to_delete)):
        lst = lst.pop(to_delete[i])

    return lst


def check_single(file_path,file_name):
    '''
    This function checks one module file and print prompt infos
    @file_path: the path of the file that you want to check
    @file_name: the name of the file taht you want to check
    '''
    flag = False
    print_flag = False
    temp_lst = []
    all_line = []
    with open(file_path,'r') as mod_file:
        for i,line in enumerate(mod_file):
            line = line.split("//")[0]
            all_line.append(line)

    with open(file_path,'r') as mod_file:
        for i,line in enumerate(mod_file):
            print_flag = False\

            if "reg" in line or "wire" in line:
                if line.lstrip()[0] == "r" or line.lstrip()[0] == "w":
                    temp_lst = extract_var(line)

                    for j in range(len(temp_lst)):
                        for n in range(i):
                            if a_in_b(temp_lst[j],all_line[n]):

                                flag = True
                                if print_flag == False:
                                    print("\n【"+file_name+"】 \nline",i+1,":","\""+temp_lst[j]+"\"",end = "")
                                    print(" referenced before defined")
                                    print("referenced at:")
                                print_flag = True
                                print("------- line",n+1)
        if flag == False:
            print("\n【"+file_name+"】 \n everything is normal!")


def check_all(file_path):
    '''
    This function checks all verilog module files in a folder
    @file_path: the path of the given folder
    '''
    file_lst = os.listdir(file_path)
    for i in range(len(file_lst)):
        if file_lst[i][-1] == "v" and file_lst[i][-2] == ".":
            temp_file_name = file_lst[i]
            temp_file_path = os.path.join(file_path,file_lst[i])
            check_single(temp_file_path,temp_file_name)


if __name__ == "__main__":
    check_all(mod_file_path)
