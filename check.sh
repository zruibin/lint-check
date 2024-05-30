#!/bin/sh

source ~/.zshrc
# echo $PATH
# nodeVersion=$(node -v)
# echo "nodeVersion: ${nodeVersion}"

# 获取脚本的全路径
script_path="$(realpath $0)"
# 提取脚本所在的目录
script_dir="$(dirname $script_path)"
# echo $script_dir

if git rev-parse --verify HEAD >/dev/null 2>&1
then
	against=HEAD
else
	against=$(git hash-object -t tree /dev/null)
fi

allownonascii=$(git config --type=bool hooks.allownonascii)

# Redirect output to stderr.
exec 1>&2

sum=0

# git diff-index --name-only --name-status
for file in $(git diff-index --name-only $against --);  do
	if [ -f "$file" ]; then
		if [[ $file == *.js || $file == *.ts || $file == *.jsx || $file == *.tsx || $file == *.vue ]]; then
			echo "eslint: $file"
			npx eslint $file

			count=$? # $?是上一指令的返回值
    		sum=$(expr ${sum} + ${count})
    		echo "$file: $count"
    		echo ""
    	elif [[ $file == *.c || $file == *.cc || $file == *.cpp || $file == *.h || $file == *.hpp ]]; then
    		echo "cpplint: $file"
    		python3 ${script_dir}/cpp-check.py $file
    		
    		count=$?
    		sum=$(expr ${sum} + ${count})
    		echo "$file: $count"
    		echo ""
		fi
	fi
done
  

if [ ${sum} -eq 0 ]; then
	echo "Check Success!"
    exit 0
else
	echo "Check Abort!"
    exit 1
fi
