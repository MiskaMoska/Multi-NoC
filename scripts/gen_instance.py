import os
# Function: generate a verilog instance from a verilog module file
# User only need to change the path of the verilog file
#//////////////////////////////////////////////////////////////////////
mod_file_root = r"F:\本科毕设相关\源代码\rtl"
mod_file_path = r"NoP\NoP.v"
#/mode_file_root//mode_file_path/
#this two parameters determine the absolute file path of the module file

MODE = 0
#/MODE/ instantation mode
#0: empty mode:no user signal name
#1: backtrack mode: user signal name is the same as module signal name(with suffix:SUFFIX)

SUFFIX = ""
#/MODE/ instantation mode
#only matters when MODE == 1

INST_SPACE = 15
#/INST_SPACE/
#this parameter determines the space between module signal name and user signal name 
#//////////////////////////////////////////////////////////////////////
mod_file_name = os.path.join(mod_file_root,mod_file_path)


def get_mod_txt(file_path):
    """
    This method returns the raw module statement text in a verilog/systemverilog file
    file_path is the path of the module file
    The text is returned in a list
    """

    flag = 0
    data = []

    with open(file_path,'r') as mod_file:
        for i,line in enumerate(mod_file):
            if "module" in line:
                flag = 1
            if flag == 1 and ";" in line:
                data.append(line)
                print(line,end = "")
                return data
            if flag == 1:
                data.append(line)
                print(line,end = "")
        
        print("cannot find module statement in:",file_path)
        return 0



def remove_cmt(mod_txt_lst,cmt = "//"):
    """
    This method removes all the comments in a module text 
    cmt is the comment string,for example,it is "//" in verilog files
    """
    for i in range(len(mod_txt_lst)):
        string = mod_txt_lst[i] 
        if "//" in string:
            idx = string.find("//")
            if idx == 0:
                mod_txt_lst[i] = ""
            else:
                mod_txt_lst[i] = string[:idx]



def pick_out_name(str,index):
    """
    This method picks out and returns the parameter/signal name from a string(str)
    The name is always in front of a character whose index is (index)
    This method will extract the name ignoring all other elements in the string  
    """

    flag = 0
    name = ""
    if index == 0:
        print("-"*100)
        print("invalid module structure:first char in line is \",\"")
        return "404nofound"

    while True:
        index -= 1
        if flag == 0 and str[index] != " ":
            flag = 1
        if flag == 1 and str[index] == " ":
            return name
        if flag == 1:
            name = str[index] + name
        if flag == 0 and index == 0:
            print("-"*100)
            print("invalid module structure:first char in line is SPACE and \",\"")
            return "404nofound"
        if flag == 1 and index == 0:
            return name



def pick_out_all_name(temp_data,instance,sign):
    """
    This method picks out all parameter/signal names in a string and append them to a list
    temp_data is the string and sign is the deviding sign of the names
    instance is the name list that is to be appended
    """

    while True:
        index = temp_data.find(sign)
        if index == -1:
            break
        else:
            temp_str = temp_data[:index+1]
            temp_data = temp_data[index+1:]

            now_name = pick_out_name(temp_str,index)
            if now_name == "404nofound":
                return
            else:
                if MODE == 0:
                    user_signal_name = ""
                elif MODE == 1:
                    user_signal_name = now_name + SUFFIX

                now_name = "    ." + now_name + "(" + user_signal_name + ")" 
                #here to add something inside the bracket

                if sign in temp_data:
                    now_name = now_name + ","
                instance.append(now_name) 



def extract_instance(mod_txt,name = "myname"):
    """
    This is the main method of generating a verilog module instance
    mod_txt is the raw module statement text that has been extracted from a module file
    name is the instance name that you give to this module
    """

    mod_str = ""
    for i in range (0,len(mod_txt)):
        mod_str += mod_txt[i].rstrip("\n") #flatten
    
    mod_lst = mod_str.split("(")
    if len(mod_lst) != 3 and len(mod_lst) != 2:
        print("error:module stucture cannot be devided into 2 or 3 parts")
        return "error"

    for i in range(len(mod_lst)):
        mod_lst[i] = mod_lst[i].rstrip().rstrip("\n")
        mod_lst[i] = mod_lst[i].rstrip(";").rstrip(")")

    instance = []
    length = len(mod_lst)

    mod_name = mod_lst[0].lstrip().lstrip("module").lstrip()
    mod_name = mod_name.rstrip().rstrip("(").rstrip("#").rstrip()

    if length == 2: #module without parameter
        instance.append(mod_name + " " + name + "(")
        temp_data = mod_lst[1] + ","
        pick_out_all_name(temp_data,instance,",")
        instance.append(");")

    elif length == 3: #module with parameter
        instance.append(mod_name + " #(")
        temp_data = mod_lst[1]
        pick_out_all_name(temp_data,instance,"=")
        instance.append(")" + name + "(")
        temp_data = mod_lst[2] + ","
        pick_out_all_name(temp_data,instance,",")
        instance.append(");")

    return instance



def beautify(inst_lst):
    """
    This method creates space between instance names and module names,
    which made the instance more beautiful
    """
    max_len = 0
    for i in range(len(inst_lst)):
        data = inst_lst[i]
        data = data.lstrip().partition("(")[0]
        if data[0] == ".":
            if len(data) > max_len:
                max_len = len(data)
    
    total_space = max_len + INST_SPACE 
    dst_inst_lst = inst_lst

    for i in range(len(inst_lst)):
        data = inst_lst[i]
        data1 = data.lstrip()
        data2 = data1.partition("(")[0]
        if data2[0] == ".":
            to_space = total_space - len(data2)
            part1 = data1[:len(data2)]
            part2 = data1[len(data2):]
            dst_inst_lst[i] = "    " + part1 + " "*to_space + part2
    
    return dst_inst_lst




# program entrance
if __name__=="__main__":

    inst_name = input("please input the instance name:")
    print("\n\n")
    print("-"*100)
    mod_txt = get_mod_txt(mod_file_name)

    if mod_txt != 0:
        print("\n\n\n")
        remove_cmt(mod_txt)
        instance = extract_instance(mod_txt,name = inst_name)
        print("-"*100)
        if instance != "error":
            instance = beautify(instance)
            for i in range(len(instance)):
                print(instance[i])

