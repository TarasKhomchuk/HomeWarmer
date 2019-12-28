$Temp1 = ''
$Temp2 = ''
$StatusText = ''
$TempStart = ''
$Hysteresis = ''

#$BaseUrl = 'http://100.67.225.187:8081'
$BaseUrl = 'http://192.168.0.130'
$InvRes = Invoke-WebRequest -Uri "$BaseUrl/boiler.tpl"
if($InvRes.StatusCode -eq 200)
{
    $TempStart = $InvRes.Forms[0].Fields.Temperature
    $Hysteresis = $InvRes.Forms[0].Fields.Hysteresis
    $StatusText = $InvRes.ParsedHtml.getElementsByTagName('font')[0].innerText
#    filter Convert-Encoding { 
#        $1251 = [System.Text.Encoding]::GetEncoding(1251) 
#        $1251.GetString([System.Text.Encoding]::Default.GetBytes($_)) 
#    } 
#    $StatusText = if(($StatusText | Convert-Encoding) -eq 'Нагрів відключено') {'Off'} else {'On'}
    if($StatusText.Length -eq 7+10){$StatusText='OFF'}
    else{
        if($StatusText.Length -eq 7+8){$StatusText='ON'}
        else{$StatusText = ''}
    }
}

$InvRes = Invoke-WebRequest -Uri "$BaseUrl/service.tpl"
if($InvRes.StatusCode -eq 200)
{
    $lines = $InvRes.Content.Split('')
    $Temp1 = $lines[44]
    $Temp2 = $lines[49]
}

#$InvRes = Invoke-WebRequest -Uri 'https://meteo.gov.ua/ua/33325/climate/climate_stations'
#if($InvRes.StatusCode -eq 200)
#{
#    $InvRes
#}

$Temp1
$Temp2
$StatusText
$TempStart
$Hysteresis