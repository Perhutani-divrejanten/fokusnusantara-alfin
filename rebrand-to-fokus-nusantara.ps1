# Rebrand script for Warta Janten to Fokus Nusantara

# Get all HTML files recursively
$files = Get-ChildItem -Recurse -Include *.html

# Replacements
$replacements = @(
    @{ Old = "Warta Janten"; New = "Fokus Nusantara" },
    @{ Old = "wartajanten"; New = "fokusnusantara" },
    @{ Old = "WartaJanten"; New = "FokusNusantara" },
    @{ Old = "WartaJanten33@gmail.com"; New = "fokusnusantara@gmail.com" },
    @{ Old = "wartajanten33@gmail.com"; New = "fokusnusantara@gmail.com" },
    @{ Old = "- Warta Janten"; New = "- Fokus Nusantara" },
    @{ Old = "WARTAJANTEN"; New = "FOKUSNUSANTARA" },
    @{ Old = "Warta<span style=`"color: #1E3A5F; font-weight: normal; font-size: 18px; margin-left: 2px;`">Janten</span>"; New = "FOKUS<span style=`"color: #6B3D51; font-weight: normal; font-size: 18px; margin-left: 2px;`">NUSANTARA</span>" },
    @{ Old = "WARTA<span style=`"color: #1E3A5F; font-weight: normal; font-size: 18px; margin-left: 2px;`">JANTEN</span>"; New = "FOKUS<span style=`"color: #6B3D51; font-weight: normal; font-size: 18px; margin-left: 2px;`">NUSANTARA</span>" }
)

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    foreach ($replacement in $replacements) {
        $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
    }

    # Fix quotation marks
    $content = $content -replace '“', '"'
    $content = $content -replace '”', '"'
    $content = $content -replace '‘', "'"
    $content = $content -replace '’', "'"
    $content = $content -replace '–', '-'
    $content = $content -replace '—', '-'
    $content = $content -replace '�', ' '

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

# Update social media URLs
$socialReplacements = @(
    @{ Old = "twitter.com/WartaJanten"; New = "twitter.com/fokusnusantara" },
    @{ Old = "facebook.com/WartaJanten"; New = "facebook.com/fokusnusantara" },
    @{ Old = "linkedin.com/company/WartaJanten"; New = "linkedin.com/company/fokusnusantara" },
    @{ Old = "instagram.com/WartaJanten"; New = "instagram.com/fokusnusantara" },
    @{ Old = "youtube.com/@WartaJanten"; New = "youtube.com/@fokusnusantara" }
)

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    foreach ($replacement in $socialReplacements) {
        $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

# Remove logo images
$logoPatterns = @(
    '<img src="img/logo\.png"[^>]*>',
    '<img[^>]*src="img/logo\.png"[^>]*>',
    '<img[^>]*src="\.\./img/logo\.png"[^>]*>'
)

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    foreach ($pattern in $logoPatterns) {
        $content = $content -replace $pattern, ''
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

# Update CSS inline colors
$colorReplacements = @(
    @{ Old = "#FFCC00"; New = "#065F46" },
    @{ Old = "#ffcc00"; New = "#065F46" },
    @{ Old = "#1E2024"; New = "#022C22" },
    @{ Old = "#1e2024"; New = "#022C22" }
)

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    foreach ($replacement in $colorReplacements) {
        $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

# Update docs
$docs = Get-ChildItem -Include *.md,*.txt,*.toml

foreach ($doc in $docs) {
    $content = Get-Content -Path $doc.FullName -Raw -Encoding UTF8

    $content = $content -replace "Warta Janten", "Fokus Nusantara"
    $content = $content -replace "wartajanten", "fokusnusantara"
    $content = $content -replace "WartaJanten", "FokusNusantara"

    Set-Content -Path $doc.FullName -Value $content -Encoding UTF8
}

Write-Host "Rebrand completed!"