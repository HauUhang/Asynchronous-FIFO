<p align="center">
  <img src="https://github.com/HauUhang/files/blob/main/readme_gif/fifo-reademe.gif" width="300"/>
  <br><a href="README.md">中文 | <a href="README_en.md">English</a>
  <br>教学相长，一起进步
</p>
    
# 什么是FIFO？
FIFO(First input First Output)：先进先出，先写入的数据先读取
    
# 异步FIFO的结构
异步FIFO的结构如图所示：
![结构](https://www.runoob.com/wp-content/uploads/2021/05/v-fifo-1.jpg)

# fifo结构
1. FIFO写逻辑控制——产生FIFO写地址、写有效信号，同时产生FIFO写满、写错等状态信号；
2. FIFO读逻辑控制——产生FIFO读地址、读有效信号，同时产生FIFO读空、读错等状态信号；
3. 时钟同步逻辑——通过两级DFF分别将写时钟域的写指针同步到读时钟域，将读时钟域的读指针同步到写时钟域；
4. 格雷码计数器——格雷码计数器中二进制计数器的低（n-1）位可以直接作为FIFO存储单元的地址指针；
5. FIFO存储体（如Memory，reg等）。

因为这里读写用的是两个不同的时钟。这将涉及到跨时钟域问题。跨时钟域的电路会带来亚稳态。
# 核心原理：跨时钟同步
**关键挑战：如何避免读写指针跨时钟域传递时的亚稳态（Metastability），并准确判断FIFO的空/满状态。**

# 解决方案：格雷码与同步机制
格雷码（Gray Code）：相邻数值仅有一位变化，减少跨时钟域同步时的错误概率。

指针同步：将写指针同步到读时钟域判断“空”，读指针同步到写时钟域判断“满”。

# 仓库使用说明：
1.verilog
* 如果你有modelsim就可以clone本地后打开ancyfifo.mpf文件，即可看到所有的代码：
![image](https://github.com/user-attachments/assets/446aaf80-9e18-4b1e-95c1-5db1e954ae08)
* 如果没有也可以选择下面的文件直接下载到本地，自己建立modelsim project（如果这里不理解需要你去学习如何使用modelsim）
Asynchronous-FIFO/
├─ fifo.v
├─ read_ctrl.v
├─ write_ctrl.v
├─ sync_gray.v
├─ dual_port_ram.v
├─ testbench.v
