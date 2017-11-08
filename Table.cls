VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Table"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Implements Initializable

'�����o�ϐ�
Private self_tbRng As Range

'�R���X�g���N�^
Private Function Initializable_Init(p() As Variant) As Object
    Set self_tbRng = p(0)
    Set Initializable_Init = Me
End Function

'�f�X�g���N�^
Private Sub Class_Terminate()
    Set self_tbRng = Nothing
End Sub

'�͈͎擾
Public Function TableRange() As Range
    Set TableRange = self_tbRng
End Function

'����̗�擾
'colObject��Integer�^�̎��AExcel�̗񐔂��w�肷��
Public Function TableColumn(ByVal colObject As Variant) As Range
    Dim rng As Range
    Select Case TypeName(colObject)
      Case "Integer"
        Set TableColumn = self_tbRng.Offset(, colObject - self_tbRng(1).Column).Resize(, 1)
      Case "String"
        For Each rng In self_tbRng.Resize(1)
            If rng.Value = colObject Then
                Set TableColumn = rng.Resize(self_tbRng.Rows.Count)
                Exit For
            End If
        Next
    End Select
End Function

'����̍s�擾
'rowObject��Integer�^�̎��AExcel�̍s�����w�肷��
Public Function TableRow(ByVal rowObject As Variant) As Range
    Dim rng As Range
    Select Case TypeName(rowObject)
      Case "Integer"
        Set TableRow = self_tbRng.Offset(rowObject - self_tbRng(1).Row).Resize(1)
      Case "String"
        For Each rng In self_tbRng.Resize(, 1)
            If rng.Value = rowObject Then
                Set TableRow = rng.Resize(, self_tbRng.Columns.Count)
                Exit For
            End If
        Next
    End Select
End Function

'����̃Z���擾
Public Function TableCells(ByVal rowObject As Variant, ByVal colObject As Variant) As Range
    Set TableCells = Intersect(Me.TableRow(rowObject), Me.TableColumn(colObject))
End Function