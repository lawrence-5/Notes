Sub InsertPictures()
    Dim fd As FileDialog
    Dim picfiles() As String
    Dim i As Integer
    Dim pic As Picture
    Dim row As Integer
    Dim col As Integer
    
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
            .Height = ActiveSheet.Cells(row, col).Height
            .Top = ActiveSheet.Cells(row, col).Top
            .Left = ActiveSheet.Cells(row, col).Left
        End With
        ' 移动到下一行（间隔两行）
        row = row + 3
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
