# 使用相对路径，避免中文目录问题
$filesDir = Join-Path -Path $PSScriptRoot -ChildPath "files"

# 定义中文到英文的映射（子文件夹）
$folderMap = @{
    "习概" = "XiGai"
    "习概背诵" = "XiGaiRecitation"
    "概率论期中20-24" = "ProbabilityMidterm20-24"
    "毛概期末" = "MaoGaiFinal"
    "毛概背诵" = "MaoGaiRecitation"
    "毛概题库" = "MaoGaiQuestions"
    "注会审计（2013-2023年，13套）" = "CPAAudit2013-2023"
    "现代信息技术" = "ModernIT"
    "管理学" = "Management"
    "金融学3学分期末卷21-22" = "Finance3CreditFinal21-22"
    "金融学期末" = "FinanceFinal"
    "金融知识点" = "FinanceKnowledge"
}

# 定义文件名部分映射（处理截断或复杂文件名）
$fileMap = @{
    "习近平新时代中国特色社会主义..." = "XiThoughtNotes"
    "1-17讲背诵电子笔..." = "RecitationNotes1-17"
    "2020-2021..." = "Probability2020-2021"
    "21-22概率..." = "Probability21-22"
    "概率论2022..." = "Probability2022"
    "19-20期末（无答案..." = "Final19-20-NoAnswers"
    "20-21期末（无答案..." = "Final20-21-NoAnswers"
    "22-23期末（无答案..." = "Final22-23-NoAnswers"
    "1_导论" = "Introduction"
    "第78章" = "Chapter7-8"
    "第二三章" = "Chapter2-3"
    "第五章" = "Chapter5"
    "第六章" = "Chapter6"
    "第四章" = "Chapter4"
    "毛概习题(1)" = "MaoGaiExercises1"
    "注会审计（2013-2023年，13..." = "CPAAudit"
    "万维“第一章..." = "WebChapter1"
    "前沿主教材1-3..." = "Textbook1-3"
    "宝典" = "Guide"
    "现代信息技术..." = "ModernITNotes"
    "理论作业1" = "Assignment1"
    "理论作业2" = "Assignment2"
    "理论作业3" = "Assignment3"
    "理论作业4" = "Assignment4"
    "理论作业5" = "Assignment5"
    "试卷" = "Exam"
    "管理学简答题(1)" = "ShortAnswer1"
    "管理学选择题库 (1)(..." = "MCQBank1"
    "管理学重点" = "KeyPoints"
    "知识点" = "KnowledgePoints"
}

# 重命名子文件夹
Get-ChildItem -Path $filesDir -Directory | ForEach-Object {
    $oldName = $_.Name
    $newName = $folderMap[$oldName]
    if ($newName -and $oldName -ne $newName) {
        Rename-Item -Path $_.FullName -NewName $newName
        Write-Host "Renamed folder: $oldName -> $newName"
    }
}

# 重命名文件
$counter = @{}
Get-ChildItem -Path $filesDir -Recurse -File | ForEach-Object {
    $ext = $_.Extension
    $dirName = [System.IO.Path]::GetFileName($_.DirectoryName)
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $mappedName = $fileMap[$baseName]
    if (-not $mappedName) {
        # 如果没有映射，使用文件夹名+编号
        $mappedName = $dirName
    }
    $counter[$dirName] = ($counter[$dirName] + 1)
    $newName = "$mappedName-$($counter[$dirName])$ext"
    Rename-Item -Path $_.FullName -NewName $newName
    Write-Host "Renamed file: $($_.Name) -> $newName"
}