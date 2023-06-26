Sub InsertPictures()
    Dim fd As FileDialog
    Dim picfiles() As String
    Dim i As Integer
    Dim pic As Picture
    Dim row As Integer
    Dim col As Integer
    Dim bottom As Double
    Dim bottomCell As Range
    
    ' 创建一个 FileDialog 对象
    Set fd = Application.FileDialog(msoFileDialogFilePicker)
    
    ' 设置 FileDialog 属性
    With fd
        .Title = "选择要插入的图片"
        .Filters.Clear
        .Filters.Add "图片文件", "*.jpg; *.jpeg; *.png; *.gif"
        .AllowMultiSelect = True
    End With
    
    ' 显示 FileDialog，并退出如果用户点击取消
    If fd.Show = False Then Exit Sub
    
    ' 把选中的文件名放入数组
    ReDim picfiles(1 To fd.SelectedItems.Count)
    For i = 1 To fd.SelectedItems.Count
        picfiles(i) = fd.SelectedItems(i)
    Next i
    
    ' 对数组进行排序
    Call BubbleSort(picfiles)
    
    row = 1
    col = 1
    
    ' 循环遍历所有选中的文件
    For i = 1 To UBound(picfiles)
        ' 插入图片并设置大小和位置
        Set pic = ActiveSheet.Pictures.Insert(picfiles(i))
        With pic
            .ShapeRange.LockAspectRatio = msoFalse
            .Width = ActiveSheet.Cells(row, col).Width
            .Top = ActiveSheet.Cells(row, col).Top
            .Left = ActiveSheet.Cells(row, col).Left
        End With
        ' 找到图片底部所在的行
        bottom = pic.Top + pic.Height
        Set bottomCell = ActiveSheet.Cells.Find(What:="*", After:=ActiveSheet.Cells(1, 1), LookIn:=xlFormulas, LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlPrevious, MatchCase:=False)
        If Not bottomCell Is Nothing Then
            row = bottomCell.Row + 3
        End If
    Next i
End Sub

Sub BubbleSort(arr() As String)
    Dim i As Long
    Dim j As Long
    Dim temp As String
    
    For i = LBound(arr) To UBound(arr) - 1
        For j = i + 1 To UBound(arr)
            If arr(i) > arr(j) Then
                temp = arr(i)
                arr(i) = arr(j)
                arr(j) = temp
            End If
        Next j
    Next i对不起，我在上述代码中的寻找底部单元格的部分出现了错误，我们需要找到图片底部所在的单元格，而不是最后一个有内容的单元格。下面是正确的代码：

```vba
Sub InsertPictures()
    Dim fd As FileDialog
    Dim picfiles() As String
    Dim i As Integer
    Dim pic As Picture
    Dim row As Integer
    Dim col As Integer
    Dim bottom As Double
    Dim bottomCell As Range
    
    ' 创建一个 FileDialog 对象
    Set fd = Application.FileDialog(msoFileDialogFilePicker)
    
    ' 设置 FileDialog 属性
    With fd
        .Title = "选择要插入的图片"
        .Filters.Clear
        .Filters.Add "图片文件", "*.jpg; *.jpeg; *.png; *.gif"
        .AllowMultiSelect = True
    End With
    
    ' 显示 FileDialog，并退出如果用户点击取消
    If fd.Show = False Then Exit Sub
    
    ' 把选中的文件名放入数组
    ReDim picfiles(1 To fd.SelectedItems.Count)
    For i = 1 To fd.SelectedItems.Count
        picfiles(i) = fd.SelectedItems(i)
    Next i
    
    ' 对数组进行排序
    Call BubbleSort(picfiles)
    
    row = 1
    col = 1
    
    ' 循环遍历所有选中的文件
    For i = 1 To UBound(picfiles)
        ' 插入图片并设置大小和位置
        Set pic = ActiveSheet.Pictures.Insert(picfiles(i))
        With pic
            .ShapeRange.LockAspectRatio = msoFalse
            '.Width = ActiveSheet.Cells(row, col).Width
            .Top = ActiveSheet.Cells(row, col).Top
            .Left = ActiveSheet.Cells(row, col).Left
        End With
        ' 找到图片底部所在的行
        
        row = pic.bottomCell.row + 3
       
    Next i
End Sub

Sub BubbleSort(arr() As String)
    Dim i As Long
    Dim j As Long
    Dim temp As String
    
    For i = LBound(arr) To UBound(arr) - 1
        For j = i + 1 To UBound(arr)
            If arr(i) > arr(j) Then
                temp = arr(i)
                arr(i) = arr(j)
                arr(j) = temp
            End If
        Next j
    Next i
End Sub
