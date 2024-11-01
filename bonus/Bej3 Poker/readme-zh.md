[Switch to English](./readme.md)

# 宝石迷阵3牌局模式数据显示工具

（此脚本仅适用于《宝石迷阵3》的原版以及基于原版的改版，游戏本体文件名必须为`Bejeweled3.exe`，否则脚本不会起作用。）

这个脚本并非用来自动分段，而是用来在LiveSplit上展示牌局统计数据的。它不需要有分段，所以你使用这个工具时应该右键点击LiveSplit窗口然后选择“Close Split”以关闭分段。

欲使用此工具，右键点击LiveSplit窗口，选择“Edit Layout”，双击“Scriptable Auto Splitter”，设置Script Path为`Bej3-Poker.asl`脚本的路径。你可以修改布局的其它设置，只要不修改左边一列的文本。

## 显示的数据

当你在玩牌局模式时，LiveSplit会显示以下统计数据：

* **Skull Generator**：当这个值充到100%而Skull Eliminator没有，添加一个骷髅。
* **Skull Eliminator**：当这个值充到100%，消除一个骷髅。
* **Skulls Busted**：已消除骷髅数。
* **Skull Coin Flips**：已抛骷髅硬币数。由于一局游戏第3次抛硬币必死，所以这个数目后面会带一个“/3”。
* **Flush**：同花手数。
* **4 of a Kind**：四条手数。
* **Full House**：葫芦手数。
* **3 of a Kind**：三条手数。
* **2 Pairs**：两对手数。
* **Spectrum**：顺子手数。
* **Pair**：一对手数。
* **Total Hands**：总手数。

当你没有在玩牌局模式时，这些数字会显示为0。
