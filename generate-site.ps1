# PowerShell script to generate static HTML comparison site

$basePath = "C:\Users\matt\Documents\Uno\AI Generation\Prompt Comparison"
$outputFile = Join-Path $basePath "index.html"

# Performance data for summary
$performanceData = @(
    @{ Name = "1. Flight Details"; AntigravityTime = 80; UnoVSCodeTime = 150; UnoVSCodeMCPTime = 105; LovableTime = 180; LovableCredits = 2.1; LovablePages = 1; DreamflowTime = 200; DreamflowCredits = 3.4; DreamflowPages = 2 }
    @{ Name = "2. Football Fantasy"; AntigravityTime = 65; UnoVSCodeTime = 110; UnoVSCodeMCPTime = 170; LovableTime = 420; LovableCredits = 2.9; LovablePages = 1; DreamflowTime = 500; DreamflowCredits = 11.5; DreamflowPages = 1 }
    @{ Name = "3. Travel Guide"; AntigravityTime = 80; UnoVSCodeTime = 120; UnoVSCodeMCPTime = 180; LovableTime = 230; LovableCredits = 2.4; LovablePages = 1; DreamflowTime = 170; DreamflowCredits = 4.1; DreamflowPages = 1 }
    @{ Name = "4. Electric Utility Dashboard"; AntigravityTime = 95; UnoVSCodeTime = 115; UnoVSCodeMCPTime = 290; LovableTime = 160; LovableCredits = 1.8; LovablePages = 1; DreamflowTime = 220; DreamflowCredits = 3.9; DreamflowPages = 1 }
    @{ Name = "5. Video Streaming"; AntigravityTime = 90; UnoVSCodeTime = 105; UnoVSCodeMCPTime = 160; LovableTime = 270; LovableCredits = 2.5; LovablePages = 2; DreamflowTime = 330; DreamflowCredits = 5.8; DreamflowPages = 4 }
    @{ Name = "6. Notes"; AntigravityTime = 90; UnoVSCodeTime = 275; UnoVSCodeMCPTime = 150; LovableTime = 180; LovableCredits = 2; LovablePages = 3; DreamflowTime = 210; DreamflowCredits = 3.8; DreamflowPages = 3 }
    @{ Name = "7. Calendar"; AntigravityTime = 75; UnoVSCodeTime = 210; UnoVSCodeMCPTime = 230; LovableTime = 290; LovableCredits = 2.2; LovablePages = 1; DreamflowTime = 225; DreamflowCredits = 7; DreamflowPages = 1 }
    @{ Name = "8. Hospital Dashboard"; AntigravityTime = 85; UnoVSCodeTime = 120; UnoVSCodeMCPTime = 150; LovableTime = 180; LovableCredits = 1.9; LovablePages = 1; DreamflowTime = 260; DreamflowCredits = 4.4; DreamflowPages = 1 }
    @{ Name = "9. Budgeting Dashboard"; AntigravityTime = 80; UnoVSCodeTime = 160; UnoVSCodeMCPTime = 140; LovableTime = 150; LovableCredits = 1.7; LovablePages = 1; DreamflowTime = 240; DreamflowCredits = 5.4; DreamflowPages = 1 }
    @{ Name = "10. Recipe Home Screen"; AntigravityTime = 80; UnoVSCodeTime = 150; UnoVSCodeMCPTime = 170; LovableTime = 120; LovableCredits = 1.6; LovablePages = 1; DreamflowTime = 185; DreamflowCredits = 4.5; DreamflowPages = 1 }
    @{ Name = "11. Fitness Tracking"; AntigravityTime = 75; UnoVSCodeTime = 120; UnoVSCodeMCPTime = 180; LovableTime = 200; LovableCredits = 1.9; LovablePages = 1; DreamflowTime = 240; DreamflowCredits = 3.5; DreamflowPages = 1 }
    @{ Name = "12. Login Register"; AntigravityTime = 60; UnoVSCodeTime = 90; UnoVSCodeMCPTime = 300; LovableTime = 155; LovableCredits = 2.1; LovablePages = 2; DreamflowTime = 255; DreamflowCredits = 3.5; DreamflowPages = 2 }
    @{ Name = "13. Travel Home Screen"; AntigravityTime = 75; UnoVSCodeTime = 400; UnoVSCodeMCPTime = 240; LovableTime = 210; LovableCredits = 2.1; LovablePages = 1; DreamflowTime = 220; DreamflowCredits = 8.5; DreamflowPages = 1 }
    @{ Name = "14. Burger Joint"; AntigravityTime = 80; UnoVSCodeTime = 100; UnoVSCodeMCPTime = 330; LovableTime = 200; LovableCredits = 1.8; LovablePages = 1; DreamflowTime = 225; DreamflowCredits = 3.4; DreamflowPages = 1 }
    @{ Name = "15. Fitness Home Screen"; AntigravityTime = 0; UnoVSCodeTime = 0; UnoVSCodeMCPTime = 0; LovableTime = 0; LovableCredits = 0; LovablePages = 1; DreamflowTime = 0; DreamflowCredits = 0; DreamflowPages = 1 }
)

# Get all project folders and sort numerically
$folders = Get-ChildItem $basePath -Directory | Where-Object { $_.Name -ne "Comparison" -and $_.Name -ne ".vscode" -and $_.Name -ne ".git" } | Sort-Object { 
    if ($_.Name -match '^(\d+)') { 
        [int]$matches[1] 
    } else { 
        999 
    }
}

$projectsData = @()

foreach ($folder in $folders) {
    $projectName = $folder.Name
    $folderPath = $folder.FullName
    
    Write-Host "Processing: $projectName"
    
    # Read prompts
    $promptsFile = Join-Path $folderPath "Prompts.txt"
    $prompts = ""
    if (Test-Path $promptsFile) {
        $prompts = Get-Content $promptsFile -Raw -Encoding UTF8
        # Fix common UTF-8 encoding issues
        $prompts = $prompts -replace [char]0x2192, '->'
        $prompts = $prompts -replace [char]0x201C, '"'
        $prompts = $prompts -replace [char]0x201D, '"'
        $prompts = $prompts -replace [char]0x2026, '...'
        $prompts = $prompts -replace [char]0x2014, '-'
        $prompts = $prompts -replace [char]0x00D7, 'x'
        $prompts = $prompts -replace [char]0x20AC, 'EUR'
        $prompts = $prompts -replace [char]0x2605, '*'
        $prompts = $prompts -replace [char]0x2019, "'"
    }
    
    # Get all images
    $images = Get-ChildItem $folderPath -Filter "*.png"
    
    $projectData = @{
        Name = $projectName
        Prompts = $prompts
        Images = @()
    }
    
    foreach ($image in $images) {
        $imageName = $image.Name
        $tool = "other"
        $label = $imageName
        
        if ($imageName -match "^Antigravity") {
            $tool = "antigravity"
        } elseif ($imageName -match "^UnoVSCodeMCP") {
            $tool = "vscodeunomcp"
        } elseif ($imageName -match "^VSCodeUnoMCP") {
            $tool = "vscodeunomcp"
        } elseif ($imageName -match "^UnoVSCode") {
            $tool = "vscodeuno"
        } elseif ($imageName -match "^VSCodeUno") {
            $tool = "vscodeuno"
        } elseif ($imageName -match "^UnoHD") {
            $tool = "uno"
        } elseif ($imageName -match "^Lovable") {
            $tool = "lovable"
        } elseif ($imageName -match "^Dreamflow") {
            $tool = "dreamflow"
        }
        
        $projectData.Images += @{
            Name = $imageName
            Tool = $tool
            Label = $imageName
            RelativePath = "$projectName/$imageName"
        }
    }
    
    # Sort images with natural sorting (handles numbers properly)
    $projectData.Images = $projectData.Images | Sort-Object { 
        # Extract parts for natural sorting
        if ($_.Name -match '^([^\d]*)(\d+)(.*)$') {
            $prefix = $matches[1]
            $number = [int]$matches[2]
            $suffix = $matches[3]
            return @($prefix, $number, $suffix)
        } else {
            return @($_.Name, 0, "")
        }
    }
    
    $projectsData += $projectData
}

# Generate HTML
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Generation Comparison - Uno vs Lovable vs Dreamflow</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f5f7fa;
            min-height: 100vh;
        }

        header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            border-bottom: 3px solid #1e3c72;
        }

        header h1 {
            color: #ffffff;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 400;
        }

        .container {
            display: flex;
            max-width: 2000px;
            margin: 2rem auto;
            gap: 2rem;
            padding: 0 1rem;
        }

        .sidebar {
            width: 300px;
            background: #ffffff;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            max-height: calc(100vh - 200px);
            overflow-y: auto;
            position: sticky;
            top: 2rem;
            border: 1px solid #e1e8ed;
        }

        .sidebar h2 {
            margin-bottom: 1rem;
            color: #1e3c72;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .project-list {
            list-style: none;
        }

        .project-list li {
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            background: #f8fafc;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
            color: #334155;
            font-weight: 500;
        }

        .project-list li:hover {
            background: #e8f2ff;
            transform: translateX(5px);
            border-left-color: #2a5298;
            color: #1e3c72;
        }

        .project-list li.active {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            font-weight: 600;
            border-left-color: #1e3c72;
            box-shadow: 0 2px 6px rgba(30, 60, 114, 0.3);
        }

        .main-content {
            flex: 1;
            background: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            min-height: 500px;
            border: 1px solid #e1e8ed;
        }

        .project-section {
            display: none;
        }

        .project-section.active {
            display: block;
        }

        .project-header h2 {
            color: #1e3c72;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            border-bottom: 3px solid #2a5298;
            padding-bottom: 0.5rem;
            font-weight: 600;
        }

        .prompts-section {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 4rem;
            border: 1px solid #e1e8ed;
        }

        .prompts-section h3 {
            color: #1e3c72;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .tool-section {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: white;
            border-radius: 8px;
            border-left: 4px solid #1e3c72;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .tool-section.uno {
            border-left-color: #4a5568;
        }

        .tool-section.lovable {
            border-left-color: #e74c3c;
        }

        .tool-section.dreamflow {
            border-left-color: #16a085;
        }

        .tool-section h4 {
            color: #1e3c72;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .tool-section-single {
            padding: 1rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .tool-section pre, .tool-section-single pre {
            white-space: pre-wrap;
            font-family: 'Courier New', monospace;
            font-size: 0.95rem;
            line-height: 1.8;
            color: #333;
            margin: 0;
        }

        .tabs {
            display: flex;
            gap: 1rem;
            margin-top: 4rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .tab-button {
            padding: 0.75rem 1.5rem;
            border: 2px solid #1e3c72;
            background: white;
            color: #1e3c72;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .tab-button:hover {
            background: #1e3c72;
            color: white;
        }

        .tab-button.active {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-color: transparent;
            box-shadow: 0 2px 6px rgba(30, 60, 114, 0.3);
        }

        .tab-uno.active.active-tool {
            background: #4a5568;
            border-color: transparent;
        }

        .tab-lovable.active.active-tool {
            background: #e74c3c;
            border-color: transparent;
        }

        .tab-dreamflow.active.active-tool {
            background: #16a085;
            border-color: transparent;
        }

        .tab-vscodeuno.active.active-tool {
            background: #9b59b6;
            border-color: transparent;
        }

        .tab-vscodeunomcp.active.active-tool {
            background: #e67e22;
            border-color: transparent;
        }

        .tab-antigravity.active.active-tool {
            background: #3498db;
            border-color: transparent;
        }

        .tab-uno {
            border-color: #4a5568;
            color: #4a5568;
        }

        .tab-uno:hover {
            background: #4a5568;
            color: white;
        }

        .tab-vscodeuno {
            border-color: #9b59b6;
            color: #9b59b6;
        }

        .tab-vscodeuno:hover {
            background: #9b59b6;
            color: white;
        }

        .tab-vscodeunomcp {
            border-color: #e67e22;
            color: #e67e22;
        }

        .tab-vscodeunomcp:hover {
            background: #e67e22;
            color: white;
        }

        .tab-lovable {
            border-color: #e74c3c;
            color: #e74c3c;
        }

        .tab-lovable:hover {
            background: #e74c3c;
            color: white;
        }

        .tab-dreamflow {
            border-color: #16a085;
            color: #16a085;
        }

        .tab-dreamflow:hover {
            background: #16a085;
            color: white;
        }

        .tab-antigravity {
            border-color: #3498db;
            color: #3498db;
        }

        .tab-antigravity:hover {
            background: #3498db;
            color: white;
        }

        .images-grid {
            margin-top: 2rem;
        }

        .tool-group {
            margin-bottom: 3rem;
        }

        .tool-group:last-child {
            margin-bottom: 0;
        }

        .tool-group-header {
            margin-bottom: 1.5rem;
            padding: 1rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 1.2rem;
            text-align: center;
            color: white;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .tool-group-header.uno {
            background: linear-gradient(135deg, #4a5568 0%, #5a6a7a 100%);
        }

        .tool-group-header.lovable {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }

        .tool-group-header.dreamflow {
            background: linear-gradient(135deg, #16a085 0%, #27ae60 100%);
        }

        .tool-group-header.vscodeuno {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
        }

        .tool-group-header.vscodeunomcp {
            background: linear-gradient(135deg, #e67e22 0%, #d35400 100%);
        }

        .tool-group-header.antigravity {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        }

        .tool-group-images {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }

        @media (max-width: 1400px) {
            .tool-group-images {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 900px) {
            .tool-group-images {
                grid-template-columns: 1fr;
            }
        }

        .image-card {
            background: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e1e8ed;
            position: relative;
        }

        .image-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12);
        }

        .image-card img {
            width: 100%;
            height: auto;
            display: block;
            cursor: pointer;
        }

        .material-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.4);
            z-index: 10;
        }

        .image-label {
            padding: 1rem;
            font-weight: 600;
            text-align: center;
        }

        .image-label.uno {
            background: linear-gradient(135deg, #4a5568 0%, #5a6a7a 100%);
            color: white;
        }

        .image-label.lovable {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
        }

        .image-label.dreamflow {
            background: linear-gradient(135deg, #16a085 0%, #27ae60 100%);
            color: white;
        }

        .image-label.vscodeuno {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            color: white;
        }

        .image-label.vscodeunomcp {
            background: linear-gradient(135deg, #e67e22 0%, #d35400 100%);
            color: white;
        }

        .summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-radius: 8px;
            overflow: hidden;
        }

        .summary-table th {
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .summary-table th:first-child {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            border-top-left-radius: 8px;
        }

        .summary-table th:nth-child(2) {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        }

        .summary-table th:nth-child(3),
        .summary-table th:nth-child(4) {
            background: linear-gradient(135deg, #7B68EE 0%, #6A5ACD 100%);
        }

        .summary-table th:nth-child(5),
        .summary-table th:nth-child(6),
        .summary-table th:nth-child(7) {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }

        .summary-table th:nth-child(8),
        .summary-table th:nth-child(9),
        .summary-table th:nth-child(10) {
            background: linear-gradient(135deg, #16a085 0%, #27ae60 100%);
        }

        .summary-table th:last-child {
            border-top-right-radius: 8px;
        }

        .value-better {
            color: #16a085;
        }

        .value-worse {
            color: #e74c3c;
        }

        .summary-table td {
            padding: 0.875rem 1rem;
            border-bottom: 1px solid #e1e8ed;
            color: #334155;
            font-size: 1rem;
        }

        .summary-table tr:last-child td {
            border-bottom: none;
            font-weight: 700;
            background: #f8fafc;
            font-size: 1.05rem;
        }

        .prompts-section .summary-table td {
            font-weight: normal;
            font-size: 1rem;
        }

        .prompts-section .summary-table tr:last-child td {
            font-weight: normal;
            font-size: 1rem;
            background: white;
        }

        .summary-table tr:hover:not(:last-child) {
            background: #f8fafc;
        }

        .prompts-section .summary-table tr:hover {
            background: #f8fafc;
        }

        .summary-table td:nth-child(2),
        .summary-table td:nth-child(3),
        .summary-table td:nth-child(4),
        .summary-table td:nth-child(5),
        .summary-table td:nth-child(6),
        .summary-table td:nth-child(7),
        .summary-table td:nth-child(8),
        .summary-table td:nth-child(9),
        .summary-table td:nth-child(10),
        .summary-table th:nth-child(2),
        .summary-table th:nth-child(3),
        .summary-table th:nth-child(4),
        .summary-table th:nth-child(5),
        .summary-table th:nth-child(6),
        .summary-table th:nth-child(7),
        .summary-table th:nth-child(8),
        .summary-table th:nth-child(9),
        .summary-table th:nth-child(10) {
            text-align: center;
        }

        .download-csv-btn {
            background: #f8fafc;
            color: #334155;
            border: 1px solid #cbd5e1;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            transition: all 0.2s ease;
        }

        .download-csv-btn:hover {
            background: #e2e8f0;
            border-color: #94a3b8;
        }

        .project-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .project-header h2 {
            color: #1e3c72;
            font-size: 2rem;
            margin-bottom: 2rem;
            border-bottom: none;
            padding-bottom: 0;
            font-weight: 600;
        }

        .header-with-button {
            border-bottom: 3px solid #2a5298;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .summary-intro {
            background: linear-gradient(135deg, #f8fafc 0%, #e8f2ff 100%);
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            border-left: 4px solid #2a5298;
        }

        .summary-intro h3 {
            color: #1e3c72;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .summary-intro p {
            color: #475569;
            line-height: 1.8;
            font-size: 1.05rem;
        }

        .lightbox {
            display: none;
            position: fixed;
            z-index: 1000;
            padding: 50px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.9);
        }

        .lightbox-content {
            margin: auto;
            display: block;
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
        }

        .lightbox-close {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }

        .lightbox-close:hover {
            color: #bbb;
        }

        .lightbox-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            color: #f1f1f1;
            font-size: 60px;
            font-weight: bold;
            cursor: pointer;
            user-select: none;
            padding: 20px;
            transition: color 0.3s ease;
        }

        .lightbox-arrow:hover {
            color: #fff;
        }

        .lightbox-arrow.disabled {
            color: #555;
            cursor: not-allowed;
            opacity: 0.3;
        }

        .lightbox-arrow-left {
            left: 20px;
        }

        .lightbox-arrow-right {
            right: 20px;
        }

        .lightbox-caption {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
            text-align: center;
            color: #ccc;
            padding: 10px 0;
            font-size: 1.2rem;
        }

        .sidebar::-webkit-scrollbar {
            width: 8px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #2c3e50;
            border-radius: 10px;
        }

        @media (max-width: 1024px) {
            .container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                max-height: 300px;
                position: relative;
                top: 0;
            }

            .images-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 1.8rem;
            }

            .images-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>AI Generation Comparison</h1>
        <p class="subtitle">Comparing Uno, Lovable, and Dreamflow outputs across different prompts</p>
    </header>

    <div class="container">
        <aside class="sidebar">
            <h2>Projects</h2>
            <ul class="project-list">
                <li data-project='summary' class='active' onclick='showProject("summary")'>Summary</li>
"@

# Add project list items
foreach ($project in $projectsData) {
    $projectId = $project.Name -replace '[^a-zA-Z0-9]', '_'
    $html += "                <li data-project='$projectId' onclick=""showProject('$projectId')"">$($project.Name)</li>`n"
}

$html += @"
            </ul>
        </aside>

        <main class="main-content">
            <div class="project-section active" id="summary">
                <div class="project-header header-with-button">
                    <h2>Performance Summary</h2>
                    <button class="download-csv-btn" onclick="downloadCSV()">Download CSV</button>
                </div>

                <table class="summary-table" id="performance-table">
                    <thead>
                        <tr>
                            <th>Project</th>
                            <th>Antigravity<br>Time (s)</th>
                            <th>Uno VS Code<br>Time (s)</th>
                            <th>Uno VS Code MCP<br>Time (s)</th>
                            <th>Lovable<br>Time (s)</th>
                            <th>Lovable<br>Credits</th>
                            <th>Lovable<br>Cost/Page ($)</th>
                            <th>Dreamflow<br>Time (s)</th>
                            <th>Dreamflow<br>Credits</th>
                            <th>Dreamflow<br>Cost/Page ($)</th>
                        </tr>
                    </thead>
                    <tbody>
"@

# Add performance data rows
foreach ($data in $performanceData) {
    # Calculate cost per page
    $lovableCostPerPage = [math]::Round(($data.LovableCredits * 0.43) / $data.LovablePages, 2)
    $dreamflowCostPerPage = [math]::Round(($data.DreamflowCredits * 0.18) / $data.DreamflowPages, 2)
    
    # Get all time values for comparison
    $allTimes = @($data.AntigravityTime, $data.UnoVSCodeTime, $data.UnoVSCodeMCPTime, $data.LovableTime, $data.DreamflowTime)
    $minTime = ($allTimes | Measure-Object -Minimum).Minimum
    $maxTime = ($allTimes | Measure-Object -Maximum).Maximum
    
    # Determine which tool is better for time (comparing all 5 tools)
    $antigravityTimeClass = if ($data.AntigravityTime -eq $minTime) { "value-better" } elseif ($data.AntigravityTime -eq $maxTime) { "value-worse" } else { "" }
    $unoVSCodeTimeClass = if ($data.UnoVSCodeTime -eq $minTime) { "value-better" } elseif ($data.UnoVSCodeTime -eq $maxTime) { "value-worse" } else { "" }
    $unoVSCodeMCPTimeClass = if ($data.UnoVSCodeMCPTime -eq $minTime) { "value-better" } elseif ($data.UnoVSCodeMCPTime -eq $maxTime) { "value-worse" } else { "" }
    $lovableTimeClass = if ($data.LovableTime -eq $minTime) { "value-better" } elseif ($data.LovableTime -eq $maxTime) { "value-worse" } else { "" }
    $dreamflowTimeClass = if ($data.DreamflowTime -eq $minTime) { "value-better" } elseif ($data.DreamflowTime -eq $maxTime) { "value-worse" } else { "" }
    
    # Determine which tool is better for credits (only Lovable vs Dreamflow)
    $lovableCreditsClass = if ($data.LovableCredits -lt $data.DreamflowCredits) { "value-better" } else { "value-worse" }
    $dreamflowCreditsClass = if ($data.DreamflowCredits -lt $data.LovableCredits) { "value-better" } else { "value-worse" }
    
    # Determine which tool is better for cost per page
    $lovableCostClass = if ($lovableCostPerPage -lt $dreamflowCostPerPage) { "value-better" } else { "value-worse" }
    $dreamflowCostClass = if ($dreamflowCostPerPage -lt $lovableCostPerPage) { "value-better" } else { "value-worse" }
    
    $html += @"
                        <tr>
                            <td>$($data.Name)</td>
                            <td class='$antigravityTimeClass'>$($data.AntigravityTime)</td>
                            <td class='$unoVSCodeTimeClass'>$($data.UnoVSCodeTime)</td>
                            <td class='$unoVSCodeMCPTimeClass'>$($data.UnoVSCodeMCPTime)</td>
                            <td class='$lovableTimeClass'>$($data.LovableTime)</td>
                            <td class='$lovableCreditsClass'>$($data.LovableCredits)</td>
                            <td class='$lovableCostClass'>$lovableCostPerPage</td>
                            <td class='$dreamflowTimeClass'>$($data.DreamflowTime)</td>
                            <td class='$dreamflowCreditsClass'>$($data.DreamflowCredits)</td>
                            <td class='$dreamflowCostClass'>$dreamflowCostPerPage</td>
                        </tr>
"@
}

# Add averages row
$antigravityTotal = 0
$unoVSCodeTotal = 0
$unoVSCodeMCPTotal = 0
$lovableTimeTotal = 0
$lovableCreditsTotal = 0
$dreamflowTimeTotal = 0
$dreamflowCreditsTotal = 0
foreach ($d in $performanceData) {
    $antigravityTotal += $d.AntigravityTime
    $unoVSCodeTotal += $d.UnoVSCodeTime
    $unoVSCodeMCPTotal += $d.UnoVSCodeMCPTime
    $lovableTimeTotal += $d.LovableTime
    $lovableCreditsTotal += $d.LovableCredits
    $dreamflowTimeTotal += $d.DreamflowTime
    $dreamflowCreditsTotal += $d.DreamflowCredits
}
$count = $performanceData.Count
$antigravityAvg = [math]::Round($antigravityTotal / $count, 1)
$unoVSCodeAvg = [math]::Round($unoVSCodeTotal / $count, 1)
$unoVSCodeMCPAvg = [math]::Round($unoVSCodeMCPTotal / $count, 1)
$lovableTimeAvg = [math]::Round($lovableTimeTotal / $count, 1)
$lovableCreditsAvg = [math]::Round($lovableCreditsTotal / $count, 1)
$dreamflowTimeAvg = [math]::Round($dreamflowTimeTotal / $count, 1)
$dreamflowCreditsAvg = [math]::Round($dreamflowCreditsTotal / $count, 1)

$html += @"
                        <tr>
                            <td>Average</td>
                            <td>$antigravityAvg</td>
                            <td>$unoVSCodeAvg</td>
                            <td>$unoVSCodeMCPAvg</td>
                            <td>$lovableTimeAvg</td>
                            <td>$lovableCreditsAvg</td>
                            <td>0.69</td>
                            <td>$dreamflowTimeAvg</td>
                            <td>$dreamflowCreditsAvg</td>
                            <td>0.57</td>
                        </tr>
                    </tbody>
                </table>
            </div>

"@

# Add project sections
foreach ($project in $projectsData) {
    $projectId = $project.Name -replace '[^a-zA-Z0-9]', '_'
    
    $html += @"
            <div class="project-section" id="$projectId">
                <div class="project-header">
                    <h2>$($project.Name)</h2>
                </div>

"@

    # Add prompts section
    if ($project.Prompts) {
        $html += @"
                <div class="prompts-section">
                    <h3>Prompts</h3>
"@
        
        # Parse prompts
        $promptLines = $project.Prompts -split "`n"
        $currentTool = ""
        $toolContent = @{
            "UNO" = @()
            "LOVABLE" = @()
            "DREAMFLOW" = @()
        }
        
        foreach ($line in $promptLines) {
            $trimmed = $line.Trim()
            if ($trimmed -eq "UNO" -or $trimmed -eq "LOVABLE" -or $trimmed -eq "DREAMFLOW") {
                $currentTool = $trimmed
            } elseif ($trimmed -and $currentTool) {
                $toolContent[$currentTool] += $trimmed
            }
        }
        
        # Count how many tools have content
        $toolsWithContent = 0
        if ($toolContent["UNO"].Count -gt 0) { $toolsWithContent++ }
        if ($toolContent["LOVABLE"].Count -gt 0) { $toolsWithContent++ }
        if ($toolContent["DREAMFLOW"].Count -gt 0) { $toolsWithContent++ }
        
        # If only one tool, don't show header
        $showHeaders = $toolsWithContent -gt 1
        
        if ($toolContent["UNO"].Count -gt 0) {
            $unoText = ($toolContent["UNO"] -join "`n")
            
            # Check if there are multiple prompts with "Prompt #" markers
            if ($unoText -match 'Prompt #\d+') {
                # Split by Prompt markers and rebuild with bullets
                $prompts = $unoText -split '(?=Prompt #\d+)'
                $bulletedPrompts = @()
                $promptNumber = 1
                
                foreach ($prompt in $prompts) {
                    $prompt = $prompt.Trim()
                    if ($prompt) {
                        # Remove "Prompt #X" line
                        $prompt = $prompt -replace '^\s*Prompt #\d+\s*[\r\n]+', ''
                        $prompt = $prompt.Trim()
                        if ($prompt) {
                            $bulletedPrompts += "$promptNumber. $prompt"
                            $promptNumber++
                        }
                    }
                }
                
                $unoText = $bulletedPrompts -join "`n`n"
            }
            
            $unoText = $unoText -replace '<', '&lt;' -replace '>', '&gt;'
            
            if ($showHeaders) {
                $html += @"
                    <div class="tool-section uno">
                        <h4>UNO</h4>
                        <pre>$unoText</pre>
                    </div>
"@
            } else {
                $html += @"
                    <div class="tool-section-single">
                        <pre>$unoText</pre>
                    </div>
"@
            }
        }
        
        if ($toolContent["LOVABLE"].Count -gt 0) {
            $lovableText = ($toolContent["LOVABLE"] -join "`n")
            
            if ($lovableText -match 'Prompt #\d+') {
                $prompts = $lovableText -split '(?=Prompt #\d+)'
                $bulletedPrompts = @()
                $promptNumber = 1
                
                foreach ($prompt in $prompts) {
                    $prompt = $prompt.Trim()
                    if ($prompt) {
                        $prompt = $prompt -replace '^\s*Prompt #\d+\s*[\r\n]+', ''
                        $prompt = $prompt.Trim()
                        if ($prompt) {
                            $bulletedPrompts += "$promptNumber. $prompt"
                            $promptNumber++
                        }
                    }
                }
                
                $lovableText = $bulletedPrompts -join "`n`n"
            }
            
            $lovableText = $lovableText -replace '<', '&lt;' -replace '>', '&gt;'
            
            if ($showHeaders) {
                $html += @"
                    <div class="tool-section lovable">
                        <h4>LOVABLE</h4>
                        <pre>$lovableText</pre>
                    </div>
"@
            } else {
                $html += @"
                    <div class="tool-section-single">
                        <pre>$lovableText</pre>
                    </div>
"@
            }
        }
        
        if ($toolContent["DREAMFLOW"].Count -gt 0) {
            $dreamflowText = ($toolContent["DREAMFLOW"] -join "`n")
            
            if ($dreamflowText -match 'Prompt #\d+') {
                $prompts = $dreamflowText -split '(?=Prompt #\d+)'
                $bulletedPrompts = @()
                $promptNumber = 1
                
                foreach ($prompt in $prompts) {
                    $prompt = $prompt.Trim()
                    if ($prompt) {
                        $prompt = $prompt -replace '^\s*Prompt #\d+\s*[\r\n]+', ''
                        $prompt = $prompt.Trim()
                        if ($prompt) {
                            $bulletedPrompts += "$promptNumber. $prompt"
                            $promptNumber++
                        }
                    }
                }
                
                $dreamflowText = $bulletedPrompts -join "`n`n"
            }
            
            $dreamflowText = $dreamflowText -replace '<', '&lt;' -replace '>', '&gt;'
            
            if ($showHeaders) {
                $html += @"
                    <div class="tool-section dreamflow">
                        <h4>DREAMFLOW</h4>
                        <pre>$dreamflowText</pre>
                    </div>
"@
            } else {
                $html += @"
                    <div class="tool-section-single">
                        <pre>$dreamflowText</pre>
                    </div>
"@
            }
        }
        
        $html += @"
                </div>

"@
    }
    
    # Add performance data for this project
    $projectPerf = $performanceData | Where-Object { $_.Name -eq $project.Name }
    if ($projectPerf) {
        $lovableCostPerPage = [math]::Round(($projectPerf.LovableCredits * 0.43) / $projectPerf.LovablePages, 2)
        $dreamflowCostPerPage = [math]::Round(($projectPerf.DreamflowCredits * 0.18) / $projectPerf.DreamflowPages, 2)
        
        $html += @"
                <div class="prompts-section">
                    <h3>Performance</h3>
                    <table class="summary-table">
                        <thead>
                            <tr>
                                <th>Tool</th>
                                <th>Time (s)</th>
                                <th>Credits</th>
                                <th>Cost/Page ($)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Antigravity</td>
                                <td>$($projectPerf.AntigravityTime)</td>
                                <td>-</td>
                                <td>-</td>
                            </tr>
                            <tr>
                                <td>Uno VS Code</td>
                                <td>$($projectPerf.UnoVSCodeTime)</td>
                                <td>-</td>
                                <td>-</td>
                            </tr>
                            <tr>
                                <td>Uno VS Code MCP</td>
                                <td>$($projectPerf.UnoVSCodeMCPTime)</td>
                                <td>-</td>
                                <td>-</td>
                            </tr>
                            <tr>
                                <td>Lovable</td>
                                <td>$($projectPerf.LovableTime)</td>
                                <td>$($projectPerf.LovableCredits)</td>
                                <td>$lovableCostPerPage</td>
                            </tr>
                            <tr>
                                <td>Dreamflow</td>
                                <td>$($projectPerf.DreamflowTime)</td>
                                <td>$($projectPerf.DreamflowCredits)</td>
                                <td>$dreamflowCostPerPage</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

"@
    }
    
    # Add tabs
    $html += @"
                <div class="tabs">
                    <button class="tab-button active" onclick="filterImages('$projectId', 'all')">All</button>
                    <button class="tab-button tab-antigravity" onclick="filterImages('$projectId', 'antigravity')">Antigravity</button>
                    <button class="tab-button tab-uno" onclick="filterImages('$projectId', 'uno')">Uno HD</button>
                    <button class="tab-button tab-vscodeuno" onclick="filterImages('$projectId', 'vscodeuno')">Uno VS Code</button>
                    <button class="tab-button tab-vscodeunomcp" onclick="filterImages('$projectId', 'vscodeunomcp')">Uno VS Code MCP</button>
                    <button class="tab-button tab-lovable" onclick="filterImages('$projectId', 'lovable')">Lovable</button>
                    <button class="tab-button tab-dreamflow" onclick="filterImages('$projectId', 'dreamflow')">Dreamflow</button>
                </div>

                <div class="images-grid" id="${projectId}_images">
"@
    
    # Group images by tool
    $imagesByTool = @{
        "antigravity" = @()
        "uno" = @()
        "vscodeuno" = @()
        "vscodeunomcp" = @()
        "lovable" = @()
        "dreamflow" = @()
        "other" = @()
    }
    
    foreach ($image in $project.Images) {
        $imagesByTool[$image.Tool] += $image
    }
    
    # Generate tool sections
    $toolOrder = @("antigravity", "uno", "vscodeuno", "vscodeunomcp", "lovable", "dreamflow", "other")
    foreach ($toolName in $toolOrder) {
        $toolImages = $imagesByTool[$toolName]
        if ($toolImages.Count -gt 0) {
            $toolDisplayName = switch ($toolName) {
                "antigravity" { "ANTIGRAVITY" }
                "uno" { "UNO HD" }
                "vscodeuno" { "UNO VS CODE" }
                "vscodeunomcp" { "UNO VS CODE MCP" }
                "lovable" { "LOVABLE" }
                "dreamflow" { "DREAMFLOW" }
                default { $toolName.ToUpper() }
            }
            
            $html += @"
                    <div class="tool-group" data-tool-group="$toolName">
                        <div class="tool-group-header $toolName">$toolDisplayName</div>
                        <div class="tool-group-images">
"@
            
            foreach ($image in $toolImages) {
                $materialBadge = ""
                if ($image.Name -match "Material") {
                    $materialBadge = "<div class='material-badge'>Material</div>"
                }
                
                $html += @"
                            <div class="image-card" data-tool="$($image.Tool)">
                                $materialBadge
                                <img src="$($image.RelativePath)" alt="$($image.Label)" onclick="openLightbox('$($image.RelativePath)', '$($image.Label)')">
                                <div class="image-label $($image.Tool)">$($image.Label)</div>
                            </div>
"@
            }
            
            $html += @"
                        </div>
                    </div>
"@
        }
    }
    
    $html += @"
                </div>
            </div>

"@
}

$html += @"
        </main>
    </div>

    <div id="lightbox" class="lightbox" onclick="closeLightbox(event)">
        <span class="lightbox-close" onclick="closeLightbox(event)">&times;</span>
        <span class="lightbox-arrow lightbox-arrow-left" id="lightbox-prev" onclick="navigateLightbox(event, -1)">&#8249;</span>
        <img class="lightbox-content" id="lightbox-img" onclick="event.stopPropagation()">
        <span class="lightbox-arrow lightbox-arrow-right" id="lightbox-next" onclick="navigateLightbox(event, 1)">&#8250;</span>
        <div class="lightbox-caption" id="lightbox-caption"></div>
    </div>

    <script>
        let currentImageIndex = -1;
        let visibleImages = [];

        function downloadCSV() {
            const table = document.getElementById('performance-table');
            let csv = [];
            
            // Get headers
            const headers = [];
            table.querySelectorAll('thead th').forEach(th => {
                headers.push('"' + th.innerText.replace(/\n/g, ' ').replace(/"/g, '""') + '"');
            });
            csv.push(headers.join(','));
            
            // Get rows
            table.querySelectorAll('tbody tr').forEach(tr => {
                const row = [];
                tr.querySelectorAll('td').forEach(td => {
                    row.push('"' + td.innerText.replace(/"/g, '""') + '"');
                });
                csv.push(row.join(','));
            });
            
            // Create download
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', 'performance-summary.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function showProject(projectId) {
            document.querySelectorAll('.project-section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(projectId).classList.add('active');
            
            document.querySelectorAll('.project-list li').forEach(li => {
                li.classList.remove('active');
                if (li.dataset.project === projectId) {
                    li.classList.add('active');
                }
            });
            
            // Scroll to container (past header)
            const container = document.querySelector('.container');
            if (container) {
                container.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
            
            updateVisibleImages();
        }

        function filterImages(projectId, tool) {
            const container = document.getElementById(projectId + '_images');
            const toolGroups = container.querySelectorAll('.tool-group');
            
            toolGroups.forEach(group => {
                if (tool === 'all' || group.dataset.toolGroup === tool) {
                    group.style.display = 'block';
                } else {
                    group.style.display = 'none';
                }
            });
            
            const section = document.getElementById(projectId);
            section.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
                btn.classList.remove('active-tool');
            });
            event.target.classList.add('active');
            if (tool !== 'all') {
                event.target.classList.add('active-tool');
            }
            
            updateVisibleImages();
        }

        function updateVisibleImages() {
            const activeSection = document.querySelector('.project-section.active');
            if (!activeSection) return;
            
            const container = activeSection.querySelector('.images-grid');
            const cards = container.querySelectorAll('.image-card');
            
            visibleImages = [];
            cards.forEach(card => {
                if (card.style.display !== 'none') {
                    const img = card.querySelector('img');
                    visibleImages.push({
                        src: img.src,
                        caption: img.alt
                    });
                }
            });
        }

        function openLightbox(src, caption) {
            updateVisibleImages();
            
            currentImageIndex = visibleImages.findIndex(img => img.src.endsWith(src));
            
            document.getElementById('lightbox').style.display = 'block';
            document.getElementById('lightbox-img').src = src;
            document.getElementById('lightbox-caption').textContent = caption;
            
            updateArrows();
        }

        function updateArrows() {
            const prevBtn = document.getElementById('lightbox-prev');
            const nextBtn = document.getElementById('lightbox-next');
            
            if (currentImageIndex <= 0 || visibleImages.length <= 1) {
                prevBtn.classList.add('disabled');
            } else {
                prevBtn.classList.remove('disabled');
            }
            
            if (currentImageIndex >= visibleImages.length - 1 || visibleImages.length <= 1) {
                nextBtn.classList.add('disabled');
            } else {
                nextBtn.classList.remove('disabled');
            }
        }

        function navigateLightbox(event, direction) {
            event.stopPropagation();
            
            const newIndex = currentImageIndex + direction;
            
            if (newIndex < 0 || newIndex >= visibleImages.length) {
                return;
            }
            
            currentImageIndex = newIndex;
            const image = visibleImages[currentImageIndex];
            
            document.getElementById('lightbox-img').src = image.src;
            document.getElementById('lightbox-caption').textContent = image.caption;
            
            updateArrows();
        }

        function closeLightbox(event) {
            if (event) {
                event.stopPropagation();
            }
            document.getElementById('lightbox').style.display = 'none';
        }

        document.addEventListener('keydown', (e) => {
            const lightbox = document.getElementById('lightbox');
            if (lightbox.style.display === 'block') {
                if (e.key === 'Escape') {
                    closeLightbox();
                } else if (e.key === 'ArrowLeft') {
                    navigateLightbox(e, -1);
                } else if (e.key === 'ArrowRight') {
                    navigateLightbox(e, 1);
                }
            }
        });

        document.querySelectorAll('.project-list li').forEach(li => {
            li.addEventListener('click', () => {
                showProject(li.dataset.project);
            });
        });
        
        window.addEventListener('load', () => {
            updateVisibleImages();
        });
    </script>
</body>
</html>
"@

# Write the HTML file
$html | Out-File -FilePath $outputFile -Encoding UTF8
Write-Host "`nGenerated: $outputFile"
Write-Host "Total projects: $($projectsData.Count)"
