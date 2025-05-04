import os

base_dir = r'C:\Users\HP\Desktop\计算机文件\vscode file\github page\zytjmy1.github.io\test_paper\files'
subject_links = []

# 遍历每个科目子目录
for subject in os.listdir(base_dir):
    subject_path = os.path.join(base_dir, subject)
    if os.path.isdir(subject_path):
        file_links = []

        for fname in os.listdir(subject_path):
            if fname.lower().endswith(('.pdf', '.docx', '.doc', '.png', '.jpg', '.jpeg')):
                rel_path = f'./{fname}'
                file_links.append(f'<li><a href="{rel_path}" download>{fname}</a></li>')

        # 写入每个科目的 index.html 文件
        if file_links:
            subject_index_path = os.path.join(subject_path, 'index.html')
            with open(subject_index_path, 'w', encoding='utf-8') as f:
                f.write(f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{subject} 下载</title>
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="/">首页</a></li>
                <li><a href="/about/">关于我</a></li>
                <li><a href="/posts/">博客文章</a></li>
                <li><a href="/test_paper/">南审考试链接</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>{subject} 文件下载</h1>
        <ul>
            {''.join(file_links)}
        </ul>
        <a href="../../index.html">返回目录</a>
    </main>
</body>
</html>''')

            # 添加到总页面链接中
            subject_links.append(f'<li><a href="./files/{subject}/index.html">{subject}</a></li>')

# 写入总 index.html 页面
main_index_path = os.path.join(os.path.dirname(base_dir), 'index.html')
with open(main_index_path, 'w', encoding='utf-8') as f:
    f.write(f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>南审考试链接</title>
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="/">首页</a></li>
                <li><a href="/about/">关于我</a></li>
                <li><a href="/posts/">博客文章</a></li>
                <li><a href="/test_paper/">南审考试链接</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>南审考试各科目链接</h1>
        <ul>
            {''.join(subject_links)}
        </ul>
    </main>
</body>
</html>''')
