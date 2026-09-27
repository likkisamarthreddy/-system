Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ======================================================================
# ALL-IN-ONE SELF-CONTAINED CONFIGURATION
# (No external files or folders needed. Copy only this .ps1 anywhere.)
# ======================================================================
$script:CLIENT_ID     = "app_EMoamEEZ73f0CkXaXp7hrann"
$script:AccountId     = "42965fa9-56eb-400f-b4d7-ba8b76f0b2bc"
$script:AccessToken   = "eyJhbGciOiJSUzI1NiIsImtpZCI6Im4wejZQcjEtdEItMTdXb1U0VGM5OHp1RDBrNmx5YU1ZQmJ3SkFEOGtSVnMiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOlsiaHR0cHM6Ly9hcGkub3BlbmFpLmNvbS92MSJdLCJjbGllbnRfaWQiOiJhcHBfRU1vYW1FRVo3M2YwQ2tYYVhwN2hyYW5uIiwiaHR0cHM6Ly9hcGkub3BlbmFpLmNvbS9hdXRoIjp7ImFtciI6WyJ1cm46b3BlbmFpOmFtcjpnb29nbGUiXSwiY2hhdGdwdF9hY2NvdW50X2lkIjoiNDI5NjVmYTktNTZlYi00MDBmLWI0ZDctYmE4Yjc2ZjBiMmJjIiwiY2hhdGdwdF9hY2NvdW50X3VzZXJfaWQiOiJ1c2VyLXFtcWdpQW93TUtVYTFWck5OUWd2Uzk1R19fNDI5NjVmYTktNTZlYi00MDBmLWI0ZDctYmE4Yjc2ZjBiMmJjIiwiY2hhdGdwdF9jb21wdXRlX3Jlc2lkZW5jeSI6Im5vX2NvbnN0cmFpbnQiLCJjaGF0Z3B0X3BsYW5fdHlwZSI6InBsdXMiLCJjaGF0Z3B0X3VzZXJfaWQiOiJ1c2VyLXFtcWdpQW93TUtVYTFWck5OUWd2Uzk1RyIsImxvY2FsaG9zdCI6dHJ1ZSwicG9pZCI6Im9yZy1lU0R4REtpSEJ6VkxCb29meFR2bHIxYksiLCJ1c2VyX2lkIjoidXNlci1xbXFnaUFvd01LVWExVnJOTlFndlM5NUcifSwiaHR0cHM6Ly9hcGkub3BlbmFpLmNvbS9wcm9maWxlIjp7ImVtYWlsIjoibG9naXQuZGljQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiTE9HSVQgRElDIn0sImlzcyI6Imh0dHBzOi8vYXV0aC5vcGVuYWkuY29tIiwicHdkX2F1dGhfdGltZSI6MTc4ODMxNjQ2NjQ4MCwic2NwIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm9mZmxpbmVfYWNjZXNzIl0sInNlc3Npb25faWQiOiJhdXRoc2Vzc19laEFjb0NzSmx4UVFvTWxpaXdCWG8zbHoiLCJzbCI6dHJ1ZSwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMDc3ODk0NDgxNDkzMzY2MjQ4ODciLCJpYXQiOjE3OTA0MDQ2MDYsImV4cCI6MTc5MTI2ODYwNiwianRpIjoiYjhiMGY4NWNiZTRjNDdkYzk5YzczMjQ0MGFmODU3YjAiLCJuYmYiOjE3OTA0MDQ2MDZ9.P0kW_6pJ_9q_kVO2zK8I4NR0YIagChMOqt3nLA80ly_N9NvkcFpfE2lGv8PRqdmACukd_wi1sm9KcOuyXronS1WWMVr1aSLxUUhlyO27gjeWsUi6GIICpj6h0cYrgcOL_Uxd-cDEvVqSTRw0hvoT6yVr9ExnD-9BEFauVatn3uPBAQ1y_F2bos5DgW_2VD0Rmt_P5Am4Xnf59PxNW6niA-v8u-iM76Sl_dfX-iJkmC0JTETESTZwy-5_DMXr5yyQFQUTZ921uZfPoDF-vnpNkGlANw-y3lf3VmVz-aUKF8WVpdcO9qe39cKU5gNvUO9VgfIUVYx3J4xq7lBMxBIUjA"
$script:RefreshToken  = "rt.1.AAASs3znxbDtI-HNphWgo0l9p5ZYkcqgvchxYyjT_LWqjKje7MhkHqL5UX1_olf0EsSx0SR8RWjvhlddfoC74a0m8bBS3eyCO4iakIAa9NEHKbQ2f2mkUOy4tH8cNcywGg2qdhRukTtxJTKhFmsF6PFa4Hn44dsiMH2mUIRCFCHSlZIwTVrxGlLOUp8ho3E"
$script:OR_KEY        = "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"
$script:OR_URL        = "https://openrouter.ai/api/v1/chat/completions"

# Check if local oauth.json has newer tokens
try {
    $oauthFile = "$env:APPDATA\ofradr\oauth.json"
    if (Test-Path $oauthFile) {
        $d = Get-Content $oauthFile -Raw | ConvertFrom-Json
        if ($d.access)  { $script:AccessToken  = [string]$d.access }
        if ($d.refresh) { $script:RefreshToken = [string]$d.refresh }
        if ($d.accountId) { $script:AccountId  = [string]$d.accountId }
    }
} catch {}

# Function to auto-refresh session if token expires
function Refresh-Session {
    if (-not $script:RefreshToken) { return $false }
    try {
        $b = "grant_type=refresh_token&refresh_token=$([Uri]::EscapeDataString($script:RefreshToken))&client_id=$($script:CLIENT_ID)"
        $r = Invoke-RestMethod -Uri "https://auth.openai.com/oauth/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $b -TimeoutSec 15
        if ($r.access_token) {
            $script:AccessToken = [string]$r.access_token
            if ($r.refresh_token) { $script:RefreshToken = [string]$r.refresh_token }
            # Save updated tokens to disk if directory exists
            try {
                $dir = "$env:APPDATA\ofradr"
                if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
                @{
                    access    = $script:AccessToken
                    refresh   = $script:RefreshToken
                    accountId = $script:AccountId
                    expires   = ([DateTimeOffset]::UtcNow.ToUnixTimeSeconds() + [long]$r.expires_in)
                    browser   = $true
                    use       = $true
                } | ConvertTo-Json | Set-Content "$dir\oauth.json" -Encoding UTF8 -Force
            } catch {}
            return $true
        }
    } catch {}
    return $false
}

$script:ready     = $true
$script:busy      = $false
$script:visible   = $true
$script:pendShot  = $null
$script:pendMode  = "chat"
$script:curModel  = "gpt-5.6-terra"   # Default model: GPT-5.6 Terra

# Global handles for async requests & timers
$script:activeReq     = $null
$script:asyncRes      = $null
$script:pollTimer     = $null
$script:pollModel     = ""
$script:pollUseTerra  = $true
$script:pollStartTick = 0
$script:retryCount    = 0

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class W3 {
    public delegate IntPtr KbdProc(int n, IntPtr w, IntPtr l);
    private static KbdProc _proc;
    public  static IntPtr  HookHandle = IntPtr.Zero;
    [StructLayout(LayoutKind.Sequential)]
    public struct KBD { public uint vk, sc, fl, t; public IntPtr ex; }
    [DllImport("user32.dll")] static extern IntPtr SetWindowsHookEx(int id, KbdProc cb, IntPtr mod, uint tid);
    [DllImport("user32.dll")] public static extern bool   UnhookWindowsHookEx(IntPtr h);
    [DllImport("user32.dll")] public static extern IntPtr CallNextHookEx(IntPtr h, int n, IntPtr w, IntPtr l);
    [DllImport("kernel32.dll")] static extern IntPtr GetModuleHandle(string m);
    [DllImport("user32.dll")] public static extern short  GetAsyncKeyState(int k);
    [DllImport("user32.dll")] public static extern bool   SetWindowDisplayAffinity(IntPtr hwnd, uint aff);
    [DllImport("user32.dll")] public static extern bool   SetWindowPos(IntPtr h, IntPtr after, int x, int y, int w, int ht, uint f);
    public static Action OnToggle, OnFocusChat, OnScreenshot, OnInspect, OnMoveL, OnMoveR, OnMoveU, OnMoveD;
    private static IntPtr Callback(int nCode, IntPtr w, IntPtr l) {
        if (nCode >= 0 && (w == (IntPtr)0x100 || w == (IntPtr)0x104)) {
            KBD k = (KBD)Marshal.PtrToStructure(l, typeof(KBD));
            bool alt = (GetAsyncKeyState(0x12) & 0x8000) != 0;
            if (alt) {
                switch (k.vk) {
                    case 0x54: if(OnToggle    !=null) OnToggle();    return (IntPtr)1;
                    case 0x4B: if(OnFocusChat !=null) OnFocusChat(); return (IntPtr)1;
                    case 0x53: if(OnScreenshot!=null) OnScreenshot();return (IntPtr)1;
                    case 0x49: if(OnInspect   !=null) OnInspect();   return (IntPtr)1;
                    case 0x25: if(OnMoveL     !=null) OnMoveL();     return (IntPtr)1;
                    case 0x27: if(OnMoveR     !=null) OnMoveR();     return (IntPtr)1;
                    case 0x26: if(OnMoveU     !=null) OnMoveU();     return (IntPtr)1;
                    case 0x28: if(OnMoveD     !=null) OnMoveD();     return (IntPtr)1;
                }
            }
        }
        return CallNextHookEx(HookHandle, nCode, w, l);
    }
    public static void Install() { _proc=Callback; HookHandle=SetWindowsHookEx(13,_proc,GetModuleHandle(null),0); }
}
"@ -ErrorAction Stop

function fnt([string]$n,[float]$s){ New-Object Drawing.Font($n,$s,[Drawing.FontStyle]::Regular) }
function fntB([string]$n,[float]$s){ New-Object Drawing.Font($n,$s,[Drawing.FontStyle]::Bold) }

# ---- MAIN FORM ----
$script:F = New-Object Windows.Forms.Form
$script:F.Text = ""
$script:F.FormBorderStyle = "None"
$script:F.TopMost = $true
$script:F.ShowInTaskbar = $false
$script:F.Width = 460
$script:F.Height = 600
$script:F.StartPosition = "Manual"
$script:F.Location = New-Object Drawing.Point(800, 50)
$script:F.BackColor = [Drawing.Color]::FromArgb(14,14,18)

# Top Title Bar
$bar = New-Object Windows.Forms.Panel
$bar.Dock = "Top"; $bar.Height = 34
$bar.BackColor = [Drawing.Color]::FromArgb(24,24,30)

$lbT = New-Object Windows.Forms.Label
$lbT.Text = "  AI Overlay"
$lbT.ForeColor = [Drawing.Color]::FromArgb(160,160,185)
$lbT.Font = fntB "Segoe UI" 8.5
$lbT.Location = New-Object Drawing.Point(0, 0)
$lbT.Size = New-Object Drawing.Size(85, 34)
$lbT.TextAlign = "MiddleLeft"

# Model Dropdown Selector
$cbModel = New-Object Windows.Forms.ComboBox
$cbModel.DropDownStyle = "DropDownList"
$cbModel.BackColor = [Drawing.Color]::FromArgb(34,34,44)
$cbModel.ForeColor = [Drawing.Color]::FromArgb(200,225,255)
$cbModel.Font = fnt "Segoe UI" 8.5
$cbModel.FlatStyle = "Flat"
$cbModel.Location = New-Object Drawing.Point(90, 5)
$cbModel.Size = New-Object Drawing.Size(165, 24)
$cbModel.Items.AddRange(@("GPT-5.6 Terra", "GPT-6 Astra", "GPT-5.6 Sol", "GPT-5.6 Luna", "GPT-4o (OpenRouter)"))
$cbModel.SelectedIndex = 0
$cbModel.Add_SelectedIndexChanged({
    switch ($cbModel.SelectedItem) {
        "GPT-5.6 Terra"       { $script:curModel = "gpt-5.6-terra" }
        "GPT-6 Astra"         { $script:curModel = "gpt-6-astra" }
        "GPT-5.6 Sol"         { $script:curModel = "gpt-5.6-sol" }
        "GPT-5.6 Luna"        { $script:curModel = "gpt-5.6-luna" }
        "GPT-4o (OpenRouter)" { $script:curModel = "openai/gpt-4o" }
    }
    $script:lbS.Text = "Model set to $($cbModel.SelectedItem)"
})

$lbHotkeys = New-Object Windows.Forms.Label
$lbHotkeys.Text = "Alt+T hide | Alt+K type | Alt+S shot | Alt+I inspect"
$lbHotkeys.ForeColor = [Drawing.Color]::FromArgb(100,100,125)
$lbHotkeys.Font = fnt "Segoe UI" 7.0
$lbHotkeys.Location = New-Object Drawing.Point(260, 0)
$lbHotkeys.Size = New-Object Drawing.Size(165, 34)
$lbHotkeys.TextAlign = "MiddleLeft"

$bX = New-Object Windows.Forms.Button
$bX.Text = "x"
$bX.Width = 30; $bX.Height = 34; $bX.Dock = "Right"
$bX.FlatStyle = "Flat"
$bX.ForeColor = [Drawing.Color]::FromArgb(200,80,80)
$bX.BackColor = [Drawing.Color]::FromArgb(24,24,30)
$bX.Font = fntB "Segoe UI" 10
$bX.FlatAppearance.BorderSize = 0
$bX.Add_Click({ $script:F.Hide(); $script:visible = $false })

$bar.Controls.AddRange(@($lbT, $cbModel, $lbHotkeys, $bX))

# Status Bar
$script:lbS = New-Object Windows.Forms.Label
$script:lbS.Text = "Ready (GPT-5.6 Terra active)"
$script:lbS.ForeColor = [Drawing.Color]::FromArgb(70,200,100)
$script:lbS.BackColor = [Drawing.Color]::FromArgb(14,14,18)
$script:lbS.Font = fnt "Segoe UI" 7.5
$script:lbS.Dock = "Top"; $script:lbS.Height = 22
$script:lbS.TextAlign = "MiddleCenter"

# RichTextBox for Chat
$script:rtb = New-Object Windows.Forms.RichTextBox
$script:rtb.Dock = "Fill"
$script:rtb.ReadOnly = $true
$script:rtb.BackColor = [Drawing.Color]::FromArgb(14,14,18)
$script:rtb.ForeColor = [Drawing.Color]::FromArgb(210,210,220)
$script:rtb.Font = fnt "Segoe UI" 10
$script:rtb.BorderStyle = "None"
$script:rtb.WordWrap = $true
$script:rtb.ScrollBars = "Vertical"

# Bottom Input Panel
$pnI = New-Object Windows.Forms.Panel
$pnI.Dock = "Bottom"; $pnI.Height = 66
$pnI.BackColor = [Drawing.Color]::FromArgb(24,24,30)

$script:txI = New-Object Windows.Forms.TextBox
$script:txI.Multiline = $true
$script:txI.BackColor = [Drawing.Color]::FromArgb(36,36,46)
$script:txI.ForeColor = [Drawing.Color]::FromArgb(220,220,230)
$script:txI.Font = fnt "Segoe UI" 10
$script:txI.BorderStyle = "None"
$script:txI.Location = New-Object Drawing.Point(8,7)
$script:txI.Size = New-Object Drawing.Size(340,52)

$bSend = New-Object Windows.Forms.Button
$bSend.Text = "Send"
$bSend.Location = New-Object Drawing.Point(356, 9)
$bSend.Size = New-Object Drawing.Size(94, 48)
$bSend.BackColor = [Drawing.Color]::FromArgb(45,95,175)
$bSend.ForeColor = [Drawing.Color]::White
$bSend.FlatStyle = "Flat"
$bSend.Font = fntB "Segoe UI" 9.5
$bSend.FlatAppearance.BorderSize = 0

$pnI.Controls.AddRange(@($script:txI, $bSend))
$pnC = New-Object Windows.Forms.Panel
$pnC.Dock = "Fill"
$pnC.Controls.Add($script:rtb)

$script:F.Controls.AddRange(@($pnC, $script:lbS, $pnI, $bar))

# Window Dragging
$script:drag = $false; $script:dragPt = [Drawing.Point]::Empty
$dDn = { param($s,$e); if($e.Button -eq 'Left'){ $script:drag = $true; $script:dragPt = $e.Location } }
$dMv = { param($s,$e); if($script:drag){ $script:F.Left += $e.X - $script:dragPt.X; $script:F.Top += $e.Y - $script:dragPt.Y } }
$dUp = { $script:drag = $false }
foreach ($c in @($bar, $lbT, $lbHotkeys)) {
    $c.Add_MouseDown($dDn); $c.Add_MouseMove($dMv); $c.Add_MouseUp($dUp)
}

function Append([string]$txt, [Drawing.Color]$col, [bool]$bold=$false) {
    $script:rtb.SelectionStart = $script:rtb.TextLength
    $script:rtb.SelectionLength = 0
    $script:rtb.SelectionColor = $col
    $script:rtb.SelectionFont = if ($bold) { fntB "Segoe UI" 10 } else { fnt "Segoe UI" 10 }
    $script:rtb.AppendText($txt + "`n")
    $script:rtb.ScrollToCaret()
}

function TakeShot {
    $b = [Windows.Forms.Screen]::PrimaryScreen.Bounds
    $bm = New-Object Drawing.Bitmap($b.Width, $b.Height)
    $g = [Drawing.Graphics]::FromImage($bm)
    $g.CopyFromScreen($b.Location, [Drawing.Point]::Empty, $b.Size)
    $g.Dispose()

    # Scale to 1280 wide if resolution is large for faster upload
    if ($b.Width -gt 1600) {
        $scale = 1280.0 / $b.Width
        $newW = 1280
        $newH = [int]($b.Height * $scale)
        $bmScaled = New-Object Drawing.Bitmap($newW, $newH)
        $gS = [Drawing.Graphics]::FromImage($bmScaled)
        $gS.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $gS.DrawImage($bm, 0, 0, $newW, $newH)
        $gS.Dispose(); $bm.Dispose()
        $bm = $bmScaled
    }

    $ms = New-Object IO.MemoryStream
    $bm.Save($ms, [Drawing.Imaging.ImageFormat]::Jpeg)
    $bm.Dispose()
    $r = [Convert]::ToBase64String($ms.ToArray())
    $ms.Dispose()
    return $r
}

function ParseSSE([string]$raw) {
    $text = ""
    foreach ($line in $raw -split "`n") {
        if ($line.StartsWith("data:")) {
            $json = $line.Substring(5).Trim()
            if ($json -and $json -ne "[DONE]") {
                try {
                    $ev = $json | ConvertFrom-Json
                    if ($ev.type -eq "response.output_text.delta") { $text += $ev.delta }
                    if ($ev.response -and $ev.response.output_text) { $text = $ev.response.output_text }
                } catch {}
            }
        }
    }
    return $text.Trim()
}

function CallAI([string]$txt, [string]$b64="", [string]$mode="chat") {
    if ($script:busy) { Append "Please wait for current response..." ([Drawing.Color]::FromArgb(255,180,50)); return }
    if (-not $txt -and -not $b64) { return }

    $script:busy = $true
    $script:txI.Text = ""

    if ($b64) {
        $prompt = if ($mode -eq "inspect") {
            "Read ALL text visible in this screenshot very carefully. Answer every question, problem, or code task shown on screen with 100% accuracy and complete explanations."
        } elseif ($txt) {
            $txt
        } else {
            "Analyze this screenshot and solve or answer anything shown."
        }
        $lbl = if ($mode -eq "inspect") { "You: [Inspect - Full Screen Read]" } else { "You: [Screenshot]$(if($txt){' - '+$txt})" }
        Append $lbl ([Drawing.Color]::FromArgb(90,150,255)) $true
    } else {
        $prompt = $txt
        Append "You: $txt" ([Drawing.Color]::FromArgb(90,150,255)) $true
    }

    $script:pollModel = $script:curModel
    $script:lbS.ForeColor = [Drawing.Color]::FromArgb(255,200,60)
    $script:lbS.Text = "$($script:pollModel) thinking..."

    try {
        $script:pollUseTerra = ($script:pollModel -ne "openai/gpt-4o")
        $script:activeReq    = $null
        $script:asyncRes     = $null

        if ($script:pollUseTerra) {
            $inputContent = @(@{type="input_text"; text=$prompt})
            if ($b64) {
                $inputContent += @{type="input_image"; image_url="data:image/jpeg;base64,$b64"}
            }
            $bodyObj = @{
                model        = $script:pollModel
                instructions = ""
                store        = $false
                stream       = $true
                input        = @(@{role="user"; content=$inputContent})
            }
            $bodyJson = $bodyObj | ConvertTo-Json -Depth 10 -Compress
            $bytes = [Text.Encoding]::UTF8.GetBytes($bodyJson)

            $req = [System.Net.HttpWebRequest]::Create("https://chatgpt.com/backend-api/codex/responses")
            $req.Method = "POST"
            $req.ContentType = "application/json"
            $req.Accept = "text/event-stream"
            $req.Timeout = 90000
            $req.Headers.Add("Authorization", "Bearer $($script:AccessToken)")
            if ($script:AccountId) { $req.Headers.Add("ChatGPT-Account-Id", $script:AccountId) }
            $req.ContentLength = $bytes.Length
            $s = $req.GetRequestStream()
            $s.Write($bytes, 0, $bytes.Length)
            $s.Close()
            $script:activeReq = $req
        } else {
            $msgs = @(@{role="user"; content=$prompt})
            $bodyObj = @{model="openai/gpt-4o"; messages=$msgs; max_tokens=2500}
            $bodyJson = $bodyObj | ConvertTo-Json -Depth 10 -Compress
            $bytes = [Text.Encoding]::UTF8.GetBytes($bodyJson)

            $req = [System.Net.HttpWebRequest]::Create($script:OR_URL)
            $req.Method = "POST"
            $req.ContentType = "application/json"
            $req.Headers.Add("Authorization", "Bearer $($script:OR_KEY)")
            $req.Headers.Add("HTTP-Referer", "https://ofradr.com")
            $req.Timeout = 90000
            $req.ContentLength = $bytes.Length
            $s = $req.GetRequestStream()
            $s.Write($bytes, 0, $bytes.Length)
            $s.Close()
            $script:activeReq = $req
        }

        # Start non-blocking BeginGetResponse
        $script:asyncRes = $script:activeReq.BeginGetResponse($null, $null)
        $script:pollStartTick = [Environment]::TickCount

        if ($script:pollTimer) {
            $script:pollTimer.Stop()
            $script:pollTimer.Dispose()
            $script:pollTimer = $null
        }

        $script:pollTimer = New-Object Windows.Forms.Timer
        $script:pollTimer.Interval = 100
        $script:pollTimer.Add_Tick({
            # Timeout guard (60 seconds)
            $elapsedMs = [Environment]::TickCount - $script:pollStartTick
            if ($elapsedMs -gt 60000 -and -not ($script:asyncRes -and $script:asyncRes.IsCompleted)) {
                $script:pollTimer.Stop(); $script:pollTimer.Dispose(); $script:pollTimer = $null
                Append "Request timed out after 60 seconds." ([Drawing.Color]::FromArgb(255,90,90)) $true
                $script:lbS.ForeColor = [Drawing.Color]::FromArgb(255,90,90)
                $script:lbS.Text = "Timed out"
                $script:busy = $false
                return
            }

            if ($script:asyncRes -and $script:asyncRes.IsCompleted) {
                $script:pollTimer.Stop(); $script:pollTimer.Dispose(); $script:pollTimer = $null
                try {
                    $resp = $script:activeReq.EndGetResponse($script:asyncRes)
                    $rd = New-Object IO.StreamReader($resp.GetResponseStream(), [Text.Encoding]::UTF8)
                    $raw = $rd.ReadToEnd(); $rd.Close(); $resp.Close()

                    $rep = ""
                    if ($script:pollUseTerra) {
                        $rep = ParseSSE $raw
                    } else {
                        $rObj = $raw | ConvertFrom-Json
                        $rep = $rObj.choices[0].message.content
                    }

                    if ($rep) {
                        Append "AI ($($script:pollModel)): $rep" ([Drawing.Color]::FromArgb(215,220,230))
                        Append "" ([Drawing.Color]::FromArgb(20,20,25))
                        $script:lbS.ForeColor = [Drawing.Color]::FromArgb(70,200,100)
                        $script:lbS.Text = "Ready - Alt+K type | Alt+S screenshot | Alt+I inspect"
                        $script:busy = $false
                    } else {
                        Append "AI: (No response text parsed)" ([Drawing.Color]::FromArgb(255,160,40))
                        $script:lbS.ForeColor = [Drawing.Color]::FromArgb(255,160,40)
                        $script:lbS.Text = "Empty response"
                        $script:busy = $false
                    }
                } catch {
                    $statusCode = 0
                    try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}

                    # If 401 Unauthorized (Session Expired), Auto-Refresh!
                    if ($statusCode -eq 401 -and $script:retryCount -lt 1) {
                        $script:retryCount++
                        Append "Session expired. Auto-refreshing credentials..." ([Drawing.Color]::FromArgb(255,180,50))
                        $refreshed = Refresh-Session
                        if ($refreshed) {
                            Append "Session refreshed successfully! Retrying..." ([Drawing.Color]::FromArgb(70,200,100))
                            $script:busy = $false
                            CallAI $prompt $b64 $mode
                            return
                        } else {
                            Append "Refresh failed. Falling back to OpenRouter GPT-4o..." ([Drawing.Color]::FromArgb(255,140,50))
                            $script:curModel = "openai/gpt-4o"
                            $cbModel.SelectedItem = "GPT-4o (OpenRouter)"
                            $script:busy = $false
                            CallAI $prompt $b64 $mode
                            return
                        }
                    }

                    $er = $_.Exception.Message
                    try {
                        $st = $_.Exception.Response.GetResponseStream()
                        $rd = New-Object IO.StreamReader($st)
                        $er = $rd.ReadToEnd()
                    } catch {}
                    Append "Error: $er" ([Drawing.Color]::FromArgb(255,90,90)) $true
                    $script:lbS.ForeColor = [Drawing.Color]::FromArgb(255,90,90)
                    $script:lbS.Text = "Error occurred"
                    $script:busy = $false
                }
            }
        })
        $script:pollTimer.Start()

    } catch {
        Append "Request failed: $($_.Exception.Message)" ([Drawing.Color]::FromArgb(255,90,90)) $true
        $script:lbS.ForeColor = [Drawing.Color]::FromArgb(255,90,90)
        $script:lbS.Text = "Request error"
        $script:busy = $false
    }
}

# Send button click
$bSend.Add_Click({
    $t = $script:txI.Text.Trim()
    if ($script:pendShot) {
        $i = $script:pendShot; $m = $script:pendMode
        $script:pendShot = $null; $script:pendMode = "chat"
        CallAI $t $i $m
    } elseif ($t) {
        CallAI $t
    }
})

# Enter to send, Esc to cancel
$script:txI.Add_KeyDown({
    param($s, $e)
    if ($e.KeyCode -eq "Return" -and -not $e.Shift) {
        $e.SuppressKeyPress = $true; $e.Handled = $true
        $t = $script:txI.Text.Trim()
        if ($script:pendShot) {
            $i = $script:pendShot; $m = $script:pendMode
            $script:pendShot = $null; $script:pendMode = "chat"
            CallAI $t $i $m
        } elseif ($t) {
            CallAI $t
        }
    }
    if ($e.KeyCode -eq "Escape") {
        $script:pendShot = $null; $script:pendMode = "chat"
        $script:lbS.ForeColor = [Drawing.Color]::FromArgb(70,200,100)
        $script:lbS.Text = "Ready ($($script:curModel))"
    }
})

# Global Hotkeys
[W3]::OnToggle = [Action]{ $script:F.Invoke([Action]{
    if ($script:visible) { $script:F.Hide(); $script:visible = $false }
    else { $script:F.Show(); [W3]::SetWindowPos($script:F.Handle, [IntPtr](-1), 0, 0, 0, 0, 0x0013); $script:visible = $true }
}) }

[W3]::OnFocusChat = [Action]{ $script:F.Invoke([Action]{
    if (-not $script:visible) { $script:F.Show(); [W3]::SetWindowPos($script:F.Handle, [IntPtr](-1), 0, 0, 0, 0, 0x0013); $script:visible = $true }
    $script:txI.Focus()
    $script:lbS.ForeColor = [Drawing.Color]::FromArgb(100,180,255)
    $script:lbS.Text = "Typing - Enter to send | Esc cancel"
}) }

[W3]::OnScreenshot = [Action]{ $script:F.Invoke([Action]{
    $script:pendShot = TakeShot; $script:pendMode = "chat"
    if (-not $script:visible) { $script:F.Show(); [W3]::SetWindowPos($script:F.Handle, [IntPtr](-1), 0, 0, 0, 0, 0x0013); $script:visible = $true }
    $script:txI.Focus()
    $script:lbS.ForeColor = [Drawing.Color]::FromArgb(100,180,255)
    $script:lbS.Text = "Screenshot taken - Press Enter to analyze (or type question first)"
}) }

[W3]::OnInspect = [Action]{ $script:F.Invoke([Action]{
    $script:pendShot = TakeShot; $script:pendMode = "inspect"
    if (-not $script:visible) { $script:F.Show(); [W3]::SetWindowPos($script:F.Handle, [IntPtr](-1), 0, 0, 0, 0, 0x0013); $script:visible = $true }
    $script:txI.Text = ""; $script:txI.Focus()
    $script:lbS.ForeColor = [Drawing.Color]::FromArgb(200,100,255)
    $script:lbS.Text = "Inspect mode - Press Enter to read all text and get answers"
}) }

[W3]::OnMoveL = [Action]{ $script:F.Invoke([Action]{ $script:F.Left -= 50 }) }
[W3]::OnMoveR = [Action]{ $script:F.Invoke([Action]{ $script:F.Left += 50 }) }
[W3]::OnMoveU = [Action]{ $script:F.Invoke([Action]{ $script:F.Top  -= 50 }) }
[W3]::OnMoveD = [Action]{ $script:F.Invoke([Action]{ $script:F.Top  += 50 }) }

# On Form Shown
$script:F.Add_Shown({
    [W3]::SetWindowDisplayAffinity($script:F.Handle, 0x00000011)
    [W3]::SetWindowPos($script:F.Handle, [IntPtr](-1), 0, 0, 0, 0, 0x0013)
    Append "AI Assistant - All-in-One Edition" ([Drawing.Color]::FromArgb(70,220,100)) $true
    Append "Active Model: GPT-5.6 Terra" ([Drawing.Color]::FromArgb(100,200,255)) $true
    Append "Auto-Refresh Session & Failover: Active" ([Drawing.Color]::FromArgb(130,190,130))
    Append "" ([Drawing.Color]::FromArgb(20,20,25))
    Append "Hotkeys:" ([Drawing.Color]::FromArgb(180,180,200)) $true
    Append "  Alt+T     : Hide / Show overlay" ([Drawing.Color]::FromArgb(140,140,165))
    Append "  Alt+K     : Focus input & type question" ([Drawing.Color]::FromArgb(140,140,165))
    Append "  Alt+S     : Screenshot + question (Enter to send)" ([Drawing.Color]::FromArgb(140,140,165))
    Append "  Alt+I     : Inspect screen (reads text & answers automatically)" ([Drawing.Color]::FromArgb(140,140,165))
    Append "  Alt+Arrows: Move overlay window" ([Drawing.Color]::FromArgb(140,140,165))
    Append "" ([Drawing.Color]::FromArgb(20,20,25))
})

[W3]::Install()
$script:F.Add_FormClosing({ [W3]::UnhookWindowsHookEx([W3]::HookHandle) })
[Windows.Forms.Application]::Run($script:F)
[W3]::UnhookWindowsHookEx([W3]::HookHandle)
