Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::VisualStyleState = [System.Windows.Forms.VisualStyles.VisualStyleState]::NoneEnabled

$header = @"
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: XXX


"@

$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, 42069)

$form = [System.Windows.Forms.Form]::new()
$form.Text = "Quick Host"
$form.Width = $form.Height = 500

$textbox = [System.Windows.Forms.TextBox]::new()
$textbox.Multiline = $true
$textbox.Width = 450
$textbox.Height = 380
$textbox.Location = [System.Drawing.Point]::new(25, 25)
$form.Controls.Add($textbox)

$button = [System.Windows.Forms.Button]::new()
$button.Text = "Start Hosting"
$button.Width = 450
$button.Height = 25
$button.Location = [System.Drawing.Point]::new(25, 420)
$button.Add_Click({
    $listener.Start()
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $listener.Stop()
    
    $response = $header.Replace("Content-Length: XXX","Content-Length: $($textbox.Text.Length)")+$textbox.Text
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($response)
    $stream.Write($buffer, 0, $buffer.Length)

    $stream.close()
    $client.Close()
})
$form.Controls.Add($button)

$form.ShowDialog()
