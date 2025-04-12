<p align="center">
  <img src="https://github.com/HauUhang/files/blob/main/readme_gif/fifo-reademe.gif" width="300"/>
  <br><a href="README.md">中文 | <a href="README_en.md">English</a>
  <br>教学相长，一起进步
</p>

# What is FIFO?
FIFO (First Input First Output): A "First-In-First-Out" structure where the first data written is the first to be read.

# What is an Asynchronous FIFO?
An asynchronous FIFO is a FIFO where read and write operations use different clock frequencies. When data needs to be transferred from one clock domain to another, this process is often referred to as "clock domain crossing." The purpose of an asynchronous FIFO is to synchronize data flow between systems operating at different clocks.
![Asynchronous FIFO](https://vlsiverify.com/wp-content/uploads/2022/12/asynchronous-fifo-usage.gif)

# Structure of an Asynchronous FIFO
The structure of an asynchronous FIFO is illustrated below:
![Structure](https://www.runoob.com/wp-content/uploads/2021/05/v-fifo-1.jpg)

# FIFO Components
1. Write Control Logic: Generates the FIFO write address, write enable signal, and status signals (e.g., write full, write error).
2. Read Control Logic: Generates the FIFO read address, read enable signal, and status signals (e.g., read empty, read error).
3. Clock Synchronization Logic: Synchronizes pointers across clock domains using a two-stage DFF (dual flip-flop) chain:
   * Write pointers are synchronized to the read clock domain.
   * Read pointers are synchronized to the write clock domain.
4. Gray Code Counter: The lower (n-1) bits of the binary counter in the Gray code module directly serve as the address pointer for the FIFO memory.
5. FIFO Memory: Storage medium (e.g., RAM, registers).

Since read and write operations use separate clocks, this introduces cross-clock domain issues, which can lead to metastability.

# Core Principle: Cross-Clock Domain Synchronization
**Key Challenge: Avoiding metastability during cross-clock domain transfer of read/write pointers while accurately determining FIFO empty/full statuses.**

# Solution: Gray Code and Synchronization Mechanism
1. Gray Code: Adjacent values differ by only one bit, minimizing errors during cross-clock domain synchronization.
2. Pointer Synchronization:
  * Write pointers are synchronized to the read clock domain to determine empty status.
  * Read pointers are synchronized to the write clock domain to determine full status.
