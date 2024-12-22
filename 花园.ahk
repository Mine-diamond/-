#IfWinActive, ahk_exe PlantsVsZombiesRH.exe ; 仅在植物大战僵尸窗口生效

; 检测是否在花园界面的标志
global IsGarden = 0

; 全局变量：用于中断当前执行
global StopExecution := false



SetTimer, CheckGarden, 1000 ; 定时器：每秒检测是否在花园界面
SetTimer, CheckStop, 5000 ; 定时器：每秒检测是否按0
return



CheckGarden:
; 搜索花园界面独有的水壶图标
ImageSearch, x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 放大镜的一部分.png
if (ErrorLevel = 0)
    IsGarden := 1 ; 如果找到图标,标志为真
else
    IsGarden := 0 ; 未找到,标志为假
return

CheckStop:
if (StopExecution) 
{
    Sleep, 4000 ; 中断1秒
    if (StopExecution)
    {
        StopExecution := false ; 中断结束
    }
}
return


SearchAndClick(){
    loop{

        if (StopExecution) ; 检查是否关闭
            break

        ; 搜索图片的位置
        ImageSearch, x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 lihe.png
        if (ErrorLevel = 0) ; 如果找到目标图片
        {
            ; 点击图片所在的位置
            MouseMove, %x%, %y%, 0
            Click
            Sleep, 1000 ;
            break
        }

        ImageSearch, x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 开始战斗.png
        if (ErrorLevel = 0) ; 如果找到目标图片
        {
            ; 点击图片所在的位置
            MouseMove, %x%, %y%, 0
            Click
            Sleep, 1000 ;
            break
        }
    }
}

; 定义中断快捷键
0::
StopExecution := true ; 按下 0 时中断当前操作
return

; 快捷键功能（1~8：选择道具）
1::
2::
3::
4::
5::
6::
7::
8::
if (IsGarden = 1) ; 仅在花园界面生效
{
    MouseGetPos, xPos, yPos ; 获取鼠标当前位置
    xPos := Round(xPos)
    yPos := Round(yPos)

    ; 根据按键移动到对应的道具位置并点击
    if (A_ThisHotkey = "1")
        MouseMove, 271 , 110 , 0 ; 道具1位置
    else if (A_ThisHotkey = "2")
        MouseMove, 370 , 110 , 0 ; 道具2位置
    else if (A_ThisHotkey = "3")
        MouseMove, 520 , 110 , 0 ; 道具3位置
    else if (A_ThisHotkey = "4")
        MouseMove, 650 , 110 , 0 ; 道具4位置
    else if (A_ThisHotkey = "5")
        MouseMove, 750 , 110 , 0 ; 道具5位置
    else if (A_ThisHotkey = "6")
        MouseMove, 900 , 110 , 0 ; 道具6位置
    else if (A_ThisHotkey = "7")
        MouseMove, 1035 , 110 , 0 ; 道具7位置
    else if (A_ThisHotkey = "8")
        MouseMove, 1150 , 110 , 0 ; 道具8位置

    Click ; 点击道具

    ; 返回原来的位置并对植物使用道具
    MouseMove, xPos, yPos , 0
    Click
}
return

; 快捷键功能（1~8：选择道具）
^1::
^2::
^3::
^4::
^5::
^6::
^7::
^8::
if (IsGarden = 1) ; 仅在花园界面生效
{
    MouseGetPos, xPos, yPos ; 获取鼠标当前位置
    xPos := Round(xPos)
    yPos := Round(yPos)

    ; 根据按键移动到对应的道具位置并点击
    if (A_ThisHotkey = "^1")
        CallPlants(271, 110) ; 水瓶位置
    else if (A_ThisHotkey = "^2")
        CallPlants(370, 110) ; 肥料位置
    else if (A_ThisHotkey = "^3")
        CallPlants(520, 110) ; 喷壶位置
    else if (A_ThisHotkey = "^4")
        CallPlants(650, 110) ; 音乐盒位置
    
    else if (A_ThisHotkey = "^6")
        MsgBox, 4, 选择框, 即将卖掉你该页的全部植物,是否确认操作？ ; 显示是/否按钮
        ifMsgBox, Yes
            CallPlantsSelling() ; 贩卖位置
    


    ; 返回原来的位置并对植物使用道具
    MouseMove, xPos, yPos , 0
}
return


; 快捷键功能（A：左翻页）
A:: ; 左翻页
if (IsGarden = 1)
{
    MouseGetPos, xPos, yPos ; 记录鼠标当前位置
    xPos := Round(xPos)
    yPos := Round(yPos)

    MouseMove, 1300 , 90 , 0 ; 左翻页图标位置
    Click
    MouseMove, xPos, yPos , 0 ; 返回原来的鼠标位置
}
return

; 快捷键功能（D：右翻页）
D:: ; 右翻页
if (IsGarden = 1)
{
    MouseGetPos, xPos, yPos ; 记录鼠标当前位置
    xPos := Round(xPos)
    yPos := Round(yPos)

    MouseMove, 1550 , 90 , 0 ; 右翻页图标位置
    Click
    MouseMove, xPos, yPos , 0 ; 返回原来的鼠标位置
}
return

L:: ; 持续刷植物
shuaBefore()
Loop
    {
        if (StopExecution) ; 检查是否关闭
        {
            StopExecution := false
            MsgBox, 已停止自动刷植物 ;
            break
        }
        
        SearchAndClick() ; 调用匹配函数

        if (StopExecution) ; 检查是否关闭
        {
            StopExecution := false
            MsgBox, 已停止! ;
            break
        }
        shuaAfter()

        if (StopExecution) ; 检查是否关闭
        {
            StopExecution := false
            MsgBox, 已停止! ;
            break
        }

        shuaBefore()
    }
return

M:: ; 持续刷植物2
shuaBefore2()
Loop
    {
        if (StopExecution) ; 检查是否关闭
        {
            StopExecution := false
            MsgBox, 已停止自动刷植物 ;
            break
        }
        
        SearchAndClick() ; 调用匹配函数

        if (StopExecution) ; 检查是否关闭
        {
            StopExecution := false
            MsgBox, 已停止! ;
            break
        }
        shuaAfter()

        if (StopExecution) ; 检查是否关闭
        {
            StopExecution := false
            MsgBox, 已停止! ;
            break
        }

        shuaBefore2()
    }
return


CallPlants(toolX, toolY) ; 循环点击植物
{
    ; 定义网格参数
    xStart := 438   ; 网格起始 X 坐标
    yStart := 264   ; 网格起始 Y 坐标
    xStep := 152    ; 每列的水平间距
    yStep := 169    ; 每行的垂直间距
    cols := 8       ; 列数（每行有几个植物）
    rows := 4       ; 行数（总共有几行植物）
; 双层循环遍历所有植物
    Loop, %rows%
    {
        row := A_Index - 1 ; 当前行索引（从 0 开始）
        Loop, %cols%
        {

            if (StopExecution) ; 检查是否中断
            {
                StopExecution := false ;
                return
            }

            col := A_Index - 1 ; 当前列索引（从 0 开始）

            ; 计算当前植物的坐标
            xPlant := xStart + col * xStep
            yPlant := yStart + row * yStep

            ; 点击道具位置
            MouseMove, %toolX%, %toolY%, 0
            Click

            ; 移动鼠标到植物位置并点击
            MouseMove, %xPlant%, %yPlant%, 0
            Click
            
        }
    }
}


CallPlantsSelling() ; 循环点击植物
{
    ; 定义网格参数
    xStart := 438   ; 网格起始 X 坐标
    yStart := 264   ; 网格起始 Y 坐标
    xStep := 152    ; 每列的水平间距
    yStep := 169    ; 每行的垂直间距
    cols := 8       ; 列数（每行有几个植物）
    rows := 4       ; 行数（总共有几行植物）
; 双层循环遍历所有植物
    Loop, %rows%
    {
        row := A_Index - 1 ; 当前行索引（从 0 开始）
        Loop, %cols%
        {

            if (StopExecution) ; 检查是否中断
            {
                StopExecution := false ;
                return
            }

            col := A_Index - 1 ; 当前列索引（从 0 开始）

            ; 计算当前植物的坐标
            xPlant := xStart + col * xStep
            yPlant := yStart + row * yStep

            ; 点击道具位置
            MouseMove, 900 , 110 , 0
            Click

            ; 移动鼠标到植物位置并点击
            MouseMove, %xPlant%, %yPlant%, 0
            Click

            ; 移动鼠标到贩卖确认位置并点击
            MouseMove, 825 , 660 , 0
            Click
            
        }
    }
}


k:: ;刷植物
shuaAfter()
shuaBefore()

return

j:: ;刷植物（从头开始）

shuaBefore()

return



shuaBefore()
{
    ; 选卡
    MouseMove, 370, 270 ,0 ;
    Click ;
    MouseMove, 520, 300 ,0 ;
    Click ;
    MouseMove, 711, 950 ,0 ;
    Click ;
    Sleep, 1500  ;
    ; 放豌豆射手
    MouseMove, 460, 100 ,0 ;
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;
    MouseMove, 460, 100 ,0 ;
    Click ;
    MouseMove, 620, 230 ,0 ;
    Click ;
    ; 放樱桃炸弹
    MouseMove, 540, 100 ,0 ;
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;
    MouseMove, 540, 100 ,0 ;
    Click ;
    MouseMove, 620, 230 ,0 ;
    Click ;
    MouseMove, 540, 100 ,0 ;
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;
    MouseMove, 540, 100 ,0 ;
    Click ;
    MouseMove, 620, 230 ,0 ;
    Click ;
    ; 开始战斗
    MouseMove, 950, 1000 ,0 ;
    Click ;
}



shuaBefore2()
{
    ; 选卡
    MouseMove, 520, 500 ,0 ;
    Click ;
    MouseMove, 690, 500 ,0 ;
    Click ;
    Sleep, 50 ;
    MouseMove, 610, 270 ,0 ;
    Click ;
    MouseMove, 920, 270 ,0 ;
    Click ;
    MouseMove, 711, 950 ,0 ;
    Click ;
    Sleep, 1500  ;
    ; 放置植物
    MouseMove, 460, 100 ,0 ; 三线射手
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;
    MouseMove, 540, 100 ,0 ;辣椒
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;
    MouseMove, 540, 100 ,0 ;
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;
    MouseMove, 600, 100 ,0 ; 坚果
    Click ;
    MouseMove, 1420, 230 ,0 ;
    Click ;
    MouseMove, 600, 100 ,0 ; 坚果
    Click ;
    MouseMove, 1560, 230 ,0 ;
    Click ;
    MouseMove, 600, 100 ,0 ; 坚果
    Click ;
    MouseMove, 1710, 230 ,0 ;
    Click ;
    
    Click ;
    ; 开始战斗
    MouseMove, 950, 1000 ,0 ;
    Click ;
    Sleep, 2500 ;
    ; 辣椒
    MouseMove, 540, 100 ,0 ;
    Click ;
    MouseMove, 460, 230 ,0 ;
    Click ;


}

shuaAfter()
{
    ; 暂停并返回到选卡界面
    Send, {Esc};
    MouseMove, 950, 630 ,0 ;
    Click ;
    Sleep, 200 ; 
    MouseMove, 830, 650 ,0 ;
    Click ;
    MouseMove, 810, 715 ,0 ;
    Click ;
    Sleep, 500  ;
}


#If ; 恢复全局作用域

^0:: ExitApp ; 按下 Ctrl + 0 键退出脚本
return