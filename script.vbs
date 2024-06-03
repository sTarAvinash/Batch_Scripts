' VBScript to convert multiple XLSX files to CSV

' Define constants
Const xlCSV = 6

' Set the input and output folders
inputFolder = "C:\Users\AvinashBarnwal\Desktop\Off\excel"
outputFolder = "C:\Users\AvinashBarnwal\Desktop\Off\excel\output\"

' Create Excel application object
Set objExcel = CreateObject("Excel.Application")
objExcel.DisplayAlerts = False

' Get a list of all XLSX files in the input folder
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder(inputFolder)
Set objFiles = objFolder.Files

' Loop through each file in the folder
For Each objFile In objFiles
    If LCase(objFSO.GetExtensionName(objFile.Name)) = "xlsx" Then
        ' Define input and output file paths
        inputFilePath = objFile.Path
        outputFilePath = outputFolder & objFSO.GetBaseName(objFile.Name) & ".csv"
        
        ' Open the XLSX file
        Set objWorkbook = objExcel.Workbooks.Open(inputFilePath)
        
        ' Save the file as CSV
        objWorkbook.SaveAs outputFilePath, xlCSV
        
        ' Close the workbook
        objWorkbook.Close False
    End If
Next

' Quit Excel application
objExcel.Quit

' Release the objects
Set objWorkbook = Nothing
Set objExcel = Nothing
Set objFiles = Nothing
Set objFolder = Nothing
Set objFSO = Nothing

' Notify the user
WScript.Echo "Batch conversion completed successfully!"
