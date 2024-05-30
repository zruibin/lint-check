#! /usr/bin/env python3
# -*- coding: utf-8 -*- 
#
# check.py
#
# Created by Ruibin.Chow on 2024/05/30.
# Copyright (c) 2024年 Ruibin.Chow All rights reserved.
# 

"""
https://www.cnblogs.com/emanlee/p/3796006.html
"""


# exit(2)


import subprocess
 
# 执行一个bash命令
cmd = "./check.sh"
process = subprocess.run(cmd, shell=True, capture_output=True, text=True)
 
# 打印命令的输出
print("命令输出: " + str(process.stdout))
 
# 打印退出状态码
print(f"退出状态码: {process.returncode}")




if __name__ == '__main__':
    pass
