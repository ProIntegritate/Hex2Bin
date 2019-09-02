Module Module1

    Sub Main()

        Dim sString() As String = Environment.GetCommandLineArgs()
        Dim sSourceFile As String = ""
        Dim sDestFile As String = ""

        If UBound(sString) < 1 Then
            Console.WriteLine("Hex2Bin: <infile> <outfile>")
        End If

        ' Don't assume user provides parameters
        Try
            sSourceFile = sString(1)
        Catch ex As Exception
        End Try
        Try
            sDestFile = sString(2)
        Catch ex As Exception
        End Try

        ' Bad things can still go wrong.
        If sSourceFile.Trim = "" Or sDestFile.Trim = "" Then End
        If Dir(sSourceFile) = "" Then End
        If FileLen(sSourceFile) = 0 Then End

        Console.WriteLine("File to read:" & sSourceFile & ", File to write:" & sDestFile)

        Dim sContent As String = System.IO.File.ReadAllText(sSourceFile)

        Dim lByteCounter As Long = 0
        Dim bContent(Len(sContent)) As Byte
        Dim sCurrentByte As String = ""

        For n = 1 To Len(sContent) Step 2
            sCurrentByte = Microsoft.VisualBasic.Mid(sContent, n, 2)
            bContent(lByteCounter) = Convert.ToInt32(sCurrentByte, 16)
            lByteCounter = lByteCounter + 1
        Next
        lByteCounter = lByteCounter - 1

        ReDim Preserve bContent(lByteCounter)

        Try ' Just in case
            System.IO.File.WriteAllBytes(sDestFile, bContent)
        Catch ex As Exception
        End Try

        Console.WriteLine("Hex2Binary - Done.")

    End Sub

End Module
