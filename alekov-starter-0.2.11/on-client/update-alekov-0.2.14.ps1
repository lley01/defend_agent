<#
  케셰브 시작 틀 업데이트 도구 (여러 출발판 → 새 판)
  - 학생 본인이 자기 on-client 폴더에서 실행합니다. 관리자 권한이 필요 없습니다.
  - 지금 프로젝트가 어느 공식 판인지(아래 고정 목록의 출발판) 파일 해시로 정확히 확인한 뒤, 바뀐 제공 파일만 새 판으로 바꿉니다.
  - student 폴더, 학생 문서, .git, 원격 저장소 설정, 커밋, 계정 연결 설정은 읽지도 쓰지도 않습니다.
  - 기본 실행은 미리보기입니다. -Apply 를 붙여야 바꿉니다.
  - 바꾸기 전에 원래 제공 파일을 프로젝트 밖 사용자 전용 폴더에 백업하고, 중간에 실패하면 모두 원래대로 되돌립니다.
  - 새 판 파일은 고정된 공식 주소의 ZIP 에서만 꺼내며, ZIP 과 파일마다 고정 SHA-256 을 대조합니다.
  이 파일은 템플릿입니다. 학생용 도구는 scripts/build-alekov-starter-updater.ps1 이 공식 ZIP 들로 아래 고정 목록을 채워 만듭니다.
#>
[CmdletBinding()]
param(
  [string]$Project = (Get-Location).Path,
  [switch]$Apply,
  [switch]$Restore,
  [string]$BackupId = '',
  [string]$ZipPath = '',
  [switch]$Json
)
Set-StrictMode -Version 3
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
try { [Console]::OutputEncoding = New-Object Text.UTF8Encoding($false) } catch {}

# BEGIN GENERATED RELEASE
$FromVersions = @('0.2.13', '0.2.11')
$ToVersion = '0.2.14'
$ZipUrl = 'https://aleph-workbench-downloads.vercel.app/alekov-starter-0.2.14.zip'
$ZipSha256 = '88294d21948386e7be2b01cb895e69722a1401e88a51183e55a326bd4700d66b'
$ZipSize = 330516
$Pins = @(
  @{ p='.on-starter-manifest.json'; o=@{ '0.2.13'='4a434b5aaaa32bf8f82124ccfc3c71c495c3314ca272c97e31cc22214aaaef56'; '0.2.11'='72af362876cb23c9433acd03f5faf9912fc9df65a9c543f30cc9d1706c3acbfe' }; n='76eb37fee1f665299602c58543ecc5335db86d28f7937c0dd613df67662fcbec' },
  @{ p='README.md'; o=@{ '0.2.13'='49fe8f0ea0ba183fbf7f2b9da4dced5cca23a78a75394a59b2aa85751cd4e495'; '0.2.11'='b8ae71728b59e12567b743b93f938548100c8879cc07184f0f2e2d496f6e452c' }; n='5877535cdd72203548c34368341f057c53fb5fa8326a188028e2bf3227e07217' },
  @{ p='docs/AI_SETUP_GUIDE.md'; o=@{ '0.2.13'='f410491eb38d83bc223458d5f312a686469e5f06257db43dbec166c463241be3'; '0.2.11'='69199ab18d82575acb6bfcbd548bd7b325da806d8f495ff8f4261dc7f6514184' }; n='f410491eb38d83bc223458d5f312a686469e5f06257db43dbec166c463241be3' },
  @{ p='docs/CONNECTION_TROUBLESHOOT.md'; o=@{ '0.2.13'='a23fb2762ed491c2f69540ae705246efaca3a42bf76e7621cded564bfed6cc44'; '0.2.11'='cb22e2cf8a9203c33254862cf6b63af92b07c4624e6196064ca59b5045a1fc1b' }; n='a23fb2762ed491c2f69540ae705246efaca3a42bf76e7621cded564bfed6cc44' },
  @{ p='docs/STUDENT_LAUNCH_GUIDE.md'; o=@{ '0.2.13'='ec1383c60f5e086297ac17b7f0ffe79004db85481579426b2be8161c608ef1d0'; '0.2.11'='78eaf4cd7ae29cc3aae5c5bc79c8d04480f90bf67281d0a8867185c8f607aa54' }; n='ec1383c60f5e086297ac17b7f0ffe79004db85481579426b2be8161c608ef1d0' },
  @{ p='package.json'; o=@{ '0.2.13'='ae99ddf39b5a7d4e70d336f193f8b4c79ffa29f857f0a5a798fe18cf0077997a'; '0.2.11'='1e111473de7526fd674a6a5fab7167921e2f3c7ccc8a45019712585e0965a419' }; n='ce6a2925d620b2055510bc509061b30e5726d3bd9041fa6d687adc5ca7c45d81' },
  @{ p='public/ai-connect.mjs'; o=@{ '0.2.13'='c536bbe5661840ee616f9ba217a2111cf50bd5493b953617d924f4d18603fbd1'; '0.2.11'='c536bbe5661840ee616f9ba217a2111cf50bd5493b953617d924f4d18603fbd1' }; n='d847fb377ec006fbe66312c5b3d26390fb2217640fc8ae8964a0bf5c2762de3c' },
  @{ p='public/app.js'; o=@{ '0.2.13'='c555770bab6790f5eca7b64a1e6e95cb1b36e2e80e3af2bdf4d8dea16b1596ac'; '0.2.11'='e4330a92e5a5bdceed3489088eef5a566dac24341955259feada845473debf7a' }; n='c555770bab6790f5eca7b64a1e6e95cb1b36e2e80e3af2bdf4d8dea16b1596ac' },
  @{ p='src/ai/service.mjs'; o=@{ '0.2.13'='cca28895bbc57319b974dff52ca711f1f47ca0c7a976c1980d08b6dff31b7360'; '0.2.11'='96537ad8da6b498be7e13e05eb9183301f07de4c40dcac7456f7b5ebf1c564e1' }; n='cca28895bbc57319b974dff52ca711f1f47ca0c7a976c1980d08b6dff31b7360' },
  @{ p='src/ai/vault-service.mjs'; o=@{ '0.2.13'='07814933b42f5b795ffd5a547e9434f4086eaebf0135004880747fd981a4a13b'; '0.2.11'='41e1830f319771bceed510edd815b467dbe1d698f01e54e0cc97592cff5427db' }; n='07814933b42f5b795ffd5a547e9434f4086eaebf0135004880747fd981a4a13b' },
  @{ p='src/connection/manager.mjs'; o=@{ '0.2.13'='6d16e6837cd777513de3b36230a96e1959a08108a69894b312104b03dec6ab39'; '0.2.11'='6d16e6837cd777513de3b36230a96e1959a08108a69894b312104b03dec6ab39' }; n='66b03a9c13f1c6ea2b91faed900873c715c926ac00fe18ac46132c6809a99f8a' },
  @{ p='src/connection/native-login.mjs'; o=@{ '0.2.13'='9d9720e44533d37083bdf2bafd28d9848585c41b91b724ef444701e2abc216a8'; '0.2.11'='9d9720e44533d37083bdf2bafd28d9848585c41b91b724ef444701e2abc216a8' }; n='2093c935f5218f5cc42bdb59545772159716dc56b4d7ba700ada917f57dc17c7' },
  @{ p='src/engine/sdp-host.mjs'; o=@{ '0.2.13'='70037627d873bac50e2f290e66a861b2a8ec2ec6adf7f5c1dbb3561ff9a2f403'; '0.2.11'='61ccacd029a8693314912eeaf3fc86f2272f793cd411042c06eca35d9b1075a9' }; n='70037627d873bac50e2f290e66a861b2a8ec2ec6adf7f5c1dbb3561ff9a2f403' },
  @{ p='src/server.mjs'; o=@{ '0.2.13'='f1a3eec9bcc007ec6fe3404cace44d88c98894092a7d8ea7f2d9afea992b9a77'; '0.2.11'='32ce16598554ffcd044e3aaa1caf91bcc70f10efb42ea279463cd2a7f7d1f010' }; n='f1a3eec9bcc007ec6fe3404cace44d88c98894092a7d8ea7f2d9afea992b9a77' },
  @{ p='tools/prepare-native-host.ps1'; o=@{ '0.2.13'='5ab1a6f3398a0593dfc816994d18b7e206f83602ddfc09ffa974d90a70b10bd8'; '0.2.11'='1bc89a9ffef358a00d072ac73202b1f25630fbf59b3092a3cb62bd04ae0c0a26' }; n='5ab1a6f3398a0593dfc816994d18b7e206f83602ddfc09ffa974d90a70b10bd8' },
  @{ p='tools/start-alekov.ps1'; o=@{ '0.2.13'='f77979813edb6c396d685e2177e08945c01cdc1fa7559d7e940c28e97cdbab90'; '0.2.11'='273c0b54337155d04d97f133a960e969a6a846b4863edddb647d755067ed18b9' }; n='f77979813edb6c396d685e2177e08945c01cdc1fa7559d7e940c28e97cdbab90' },
  @{ p='vendor/clco-http.mjs'; o=@{ '0.2.13'='7b846092ac7a00975e00c2001d63bf47dd5818b73513349c26cedd3dbded6289'; '0.2.11'='e9c12c59c90d6b102726c3912cf26174c9b0c91160f83ed226092de6eb904667' }; n='7b846092ac7a00975e00c2001d63bf47dd5818b73513349c26cedd3dbded6289' }
)
# END GENERATED RELEASE

$Absent = 'absent'
$BackupSchema = 'alekov.self-update.backup.v2'

# touched: 이번 실행이 프로젝트 파일을 한 번이라도 바꿨는지(되돌린 경우 포함). Refuse 로 끝나면 false 입니다.
$script:Result = [ordered]@{ ok=$false; code=''; mode=''; from=''; to=$ToVersion; project=''; backupId=''; changed=@(); touched=$false; message='' }
$sid = [Security.Principal.WindowsIdentity]::GetCurrent().User
$script:OwnedTemps = New-Object Collections.Generic.List[string]
$faults = @(([string]$env:ALEKOV_SELF_UPDATE_FAULT).Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ })

function Say([string]$text) { if (-not $Json) { Write-Host $text } }
function CleanOwnedTemps {
  # 이번 실행이 직접 만든 임시 파일만 지웁니다. 원래 있던 파일·폴더·연결 지점은 건드리지 않습니다.
  foreach ($t in @($script:OwnedTemps.ToArray())) {
    try { if ([IO.File]::Exists($t) -and -not ((Get-Item -LiteralPath $t -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) { [IO.File]::Delete($t) } } catch {}
  }
}
function Finish([int]$exitCode) {
  CleanOwnedTemps
  if ($Json) { $script:Result | ConvertTo-Json -Compress -Depth 4 | Write-Output }
  exit $exitCode
}
trap {
  $script:Result.ok = $false; $script:Result.code = 'UPDATE_INTERNAL_ERROR'; $script:Result.message = $_.Exception.Message
  Say ''; Say '[중단] UPDATE_INTERNAL_ERROR'; Say ('예상하지 못한 오류가 났습니다: ' + $_.Exception.Message)
  Say '프로젝트 파일이 바뀌었는지 이 도구로는 확인하지 못했습니다. 이 창을 캡처해서 담당 강사에게 보내 주세요.'
  Finish 5
}
function Refuse([string]$code, [string]$text) {
  # 프로젝트 파일을 하나도 바꾸기 전에만 부릅니다.
  $script:Result.code = $code; $script:Result.message = $text
  Say ''; Say "[중단] $code"; Say $text; Say '프로젝트 파일은 하나도 바꾸지 않았습니다.'
  Finish 2
}
function FailAfterChange([string]$code, [string]$text, [int]$exitCode) {
  $script:Result.code = $code; $script:Result.message = $text; $script:Result.touched = $true
  Say ''; Say "[실패] $code"; Say $text
  Finish $exitCode
}
function FaultAt([string]$name) {
  if ($faults -contains $name) { throw "시험용 강제 실패 ($name)" }
}
function Sha256Bytes([byte[]]$bytes) {
  return ([BitConverter]::ToString([Security.Cryptography.SHA256]::Create().ComputeHash($bytes))).Replace('-', '').ToLowerInvariant()
}
function Sha256File([string]$path) {
  $s = [IO.File]::OpenRead($path)
  try { return ([BitConverter]::ToString([Security.Cryptography.SHA256]::Create().ComputeHash($s))).Replace('-', '').ToLowerInvariant() } finally { $s.Dispose() }
}
function LfHashBytes([byte[]]$bytes) {
  # Git 의 줄바꿈 자동 변환(CRLF)으로 받은 사본도 같은 파일로 봅니다.
  $out = New-Object IO.MemoryStream
  for ($i = 0; $i -lt $bytes.Length; $i++) {
    if ($bytes[$i] -eq 13 -and ($i + 1) -lt $bytes.Length -and $bytes[$i + 1] -eq 10) { continue }
    $out.WriteByte($bytes[$i])
  }
  return Sha256Bytes $out.ToArray()
}
function IsReparse([string]$path) {
  $item = Get-Item -LiteralPath $path -Force -ErrorAction Stop
  return [bool]($item.Attributes -band [IO.FileAttributes]::ReparsePoint)
}
function CurrentHash([string]$full) {
  # 파일이 없으면 'absent'. 파일 자리에 폴더나 바로가기가 있으면 멈춥니다.
  if ([IO.File]::Exists($full)) {
    if (IsReparse $full) { throw "파일이 바로가기(연결 지점)로 바뀌었습니다: $full" }
    return Sha256File $full
  }
  if (Test-Path -LiteralPath $full) { throw "파일 자리에 폴더가 있습니다: $full" }
  return $Absent
}
function PrivateDirectorySecurity {
  $security = New-Object Security.AccessControl.DirectorySecurity
  $rule = New-Object Security.AccessControl.FileSystemAccessRule($sid, 'FullControl', 'ContainerInherit, ObjectInherit', 'None', 'Allow')
  $security.SetOwner($sid); $security.SetAccessRuleProtection($true, $false); $security.AddAccessRule($rule)
  return $security
}
function CheckPrivateAcl([string]$path) {
  $acl = Get-Acl -LiteralPath $path
  $rules = @($acl.GetAccessRules($true, $true, [Security.Principal.SecurityIdentifier]))
  if ($acl.GetOwner([Security.Principal.SecurityIdentifier]).Value -cne $sid.Value -or -not $acl.AreAccessRulesProtected -or $rules.Count -ne 1 -or $rules[0].IdentityReference.Value -cne $sid.Value -or $rules[0].AccessControlType -ne [Security.AccessControl.AccessControlType]::Allow -or $rules[0].FileSystemRights -ne [Security.AccessControl.FileSystemRights]::FullControl) { return $false }
  return $true
}
function UnsafeBackupText([string]$path) {
  return "백업 폴더의 상태를 안전하다고 확인하지 못했습니다: $path`n이 폴더에는 이전 업데이트의 원본 파일이 들어 있을 수 있으니 지우거나 옮기지 말고, 그대로 둔 채 담당 강사에게 알려 주세요."
}
function EnsurePrivateDirectory([string]$path) {
  if (-not (Test-Path -LiteralPath $path)) { [void][IO.Directory]::CreateDirectory($path, (PrivateDirectorySecurity)) }
  if (-not (Test-Path -LiteralPath $path -PathType Container) -or (IsReparse $path) -or -not (CheckPrivateAcl $path)) { Refuse 'UPDATE_BACKUP_UNSAFE' (UnsafeBackupText $path) }
}
function CheckPrivateDirectory([string]$path, [string]$code) {
  if (-not (Test-Path -LiteralPath $path -PathType Container) -or (IsReparse $path) -or -not (CheckPrivateAcl $path)) { Refuse $code (UnsafeBackupText $path) }
}
function WriteOwnedTemp([string]$dir, [string]$name, [byte[]]$bytes) {
  # 매번 새 무작위 이름으로, 이미 같은 이름이 있으면 실패하도록(CreateNew) 만듭니다. 남의 파일을 덮거나 채택하지 않습니다.
  $tmp = Join-Path $dir ('.' + $name + '.alekov-' + [Guid]::NewGuid().ToString('N') + '.tmp')
  $fs = New-Object IO.FileStream($tmp, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
  $script:OwnedTemps.Add($tmp)
  try { $fs.Write($bytes, 0, $bytes.Length); $fs.Flush($true) } finally { $fs.Dispose() }
  return $tmp
}
function PutState([string]$target, $bytes, [string]$expectHash) {
  # $bytes 가 $null 이면 그 자리를 '없음' 으로 되돌립니다(이번에 새로 만든 제공 파일을 되돌릴 때만 씁니다).
  if ($null -eq $bytes) {
    if ([IO.File]::Exists($target)) {
      if (IsReparse $target) { throw "지울 파일이 바로가기(연결 지점)로 바뀌었습니다: $target" }
      [IO.File]::Delete($target)
    }
    if ((CurrentHash $target) -ne $Absent) { throw "되돌린 뒤 확인 실패: $target" }
    return
  }
  $dir = Split-Path -Parent $target
  if (-not [IO.Directory]::Exists($dir)) { [void][IO.Directory]::CreateDirectory($dir) }
  if (IsReparse $dir) { throw "폴더가 바로가기(연결 지점)로 되어 있습니다: $dir" }
  $tmp = WriteOwnedTemp $dir (Split-Path -Leaf $target) ([byte[]]$bytes)
  if ((Sha256File $tmp) -ne $expectHash) { throw "임시 파일 확인 실패: $target" }
  if ([IO.File]::Exists($target)) {
    if (IsReparse $target) { throw "바꿀 파일이 바로가기(연결 지점)로 바뀌었습니다: $target" }
    [IO.File]::Replace($tmp, $target, [NullString]::Value)
  } else {
    if (Test-Path -LiteralPath $target) { throw "파일 자리에 폴더가 있습니다: $target" }
    [IO.File]::Move($tmp, $target)
  }
  if ((Sha256File $target) -ne $expectHash) { throw "교체 후 확인 실패: $target" }
}
function WriteBackupJson([string]$dir, $record) {
  FaultAt ('meta:' + $record.state)
  $bytes = (New-Object Text.UTF8Encoding($false)).GetBytes(($record | ConvertTo-Json -Depth 5))
  $final = Join-Path $dir 'backup.json'
  $tmp = WriteOwnedTemp $dir 'backup.json' $bytes
  if ((Sha256File $tmp) -ne (Sha256Bytes $bytes)) { throw '백업 기록 임시 파일 확인 실패' }
  if (Test-Path -LiteralPath $final) {
    if (IsReparse $final) { throw '백업 기록 파일이 바로가기로 되어 있습니다' }
    [IO.File]::Replace($tmp, $final, [NullString]::Value)
  } else { [IO.File]::Move($tmp, $final) }
  if ((Sha256File $final) -ne (Sha256Bytes $bytes)) { throw '백업 기록 확인 실패' }
}
function UndoSteps($steps) {
  # 이번 실행이 바꾼 파일(현재 내용이 이번에 쓴 내용과 같은 파일)만 거꾸로 되돌립니다.
  $ok = $true
  $all = @($steps)
  for ($j = $all.Count - 1; $j -ge 0; $j--) {
    $s = $all[$j]
    try {
      $cur = CurrentHash $s.full
      if ($cur -eq $s.expect) { PutState $s.full $s.undoBytes $s.undoHash }
      elseif ($cur -ne $s.undoHash) { $ok = $false }
    } catch { $ok = $false }
  }
  return $ok
}
function RunSwaps($plan, [string]$phase) {
  $done = New-Object Collections.Generic.List[object]
  try {
    $i = 0
    foreach ($step in $plan) {
      FaultAt "${phase}:$i"
      if ((CurrentHash $step.full) -ne $step.undoHash) { throw "확인한 뒤에 파일이 바뀌었습니다: $($step.full)" }
      $done.Add($step)
      PutState $step.full $step.bytes $step.expect
      $i++
    }
    return @{ ok=$true; error=''; undone=$true }
  } catch {
    $err = $_.Exception.Message
    $undoOk = UndoSteps $done.ToArray()
    return @{ ok=$false; error=$err; undone=$undoOk }
  }
}

# 0) PowerShell 실행 환경과 옵션 확인
if ($ExecutionContext.SessionState.LanguageMode -ne 'FullLanguage') {
  Refuse 'UPDATE_POWERSHELL_RESTRICTED' '이 PC 의 PowerShell 이 제한 모드라 업데이트 도구를 실행할 수 없습니다. 담당 강사에게 알려 주세요.'
}
if (-not $ToVersion -or $FromVersions.Count -eq 0 -or $Pins.Count -eq 0 -or $ZipSha256 -notmatch '^[0-9a-f]{64}$') {
  Refuse 'UPDATE_TOOL_NOT_RELEASED' '이 파일은 공식 배포용으로 만들어진 도구가 아닙니다. 포털에서 안내한 업데이트 도구를 받아 실행하세요.'
}
if ($Apply -and $Restore) { Refuse 'UPDATE_BAD_OPTION' '-Apply 와 -Restore 는 함께 쓸 수 없습니다. 하나만 골라 실행하세요.' }
if ($BackupId -and -not $Restore) { Refuse 'UPDATE_BAD_OPTION' '-BackupId 는 -Restore 와 함께만 씁니다.' }
if ($BackupId -and $BackupId -notmatch '^[0-9]{8}-[0-9]{6}-[0-9a-f]{6}$') { Refuse 'UPDATE_BAD_OPTION' "백업 번호 형식이 맞지 않습니다: $BackupId" }

# 1) 프로젝트 폴더 확인
try { $root = [IO.Path]::GetFullPath($Project).TrimEnd('\') } catch { Refuse 'UPDATE_NOT_PROJECT' "폴더 경로를 읽을 수 없습니다: $Project" }
if ($root -notmatch '^[A-Za-z]:\\') { Refuse 'UPDATE_NOT_PROJECT' "내 PC 의 드라이브 경로(C:\... 같은 형태)에서만 실행할 수 있습니다: $root" }
if (-not (Test-Path -LiteralPath (Join-Path $root 'package.json')) -and (Test-Path -LiteralPath (Join-Path $root 'on-client\package.json'))) { $root = Join-Path $root 'on-client' }
foreach ($need in @('package.json', '.on-starter-manifest.json', 'student\extension.mjs', 'src\server.mjs')) {
  if (-not (Test-Path -LiteralPath (Join-Path $root $need) -PathType Leaf)) {
    Refuse 'UPDATE_NOT_PROJECT' "케셰브 시작 틀 폴더가 아닙니다. on-client 폴더에서 실행하세요.`n찾지 못한 파일: $need`n확인한 폴더: $root"
  }
}
$script:Result.project = $root
$walk = $root
while ($walk) {
  if (IsReparse $walk) { Refuse 'UPDATE_UNSAFE_PATH' "프로젝트 경로 중간에 바로가기(연결 지점)가 있습니다: $walk`n실제 폴더 경로로 옮긴 뒤 실행하세요." }
  $parent = Split-Path -Parent $walk
  if (-not $parent -or $parent -eq $walk) { break }
  $walk = $parent
}
$projectDigest = (Sha256Bytes ([Text.Encoding]::UTF8.GetBytes($root.ToLowerInvariant()))).Substring(0, 16)
$stateRoot = Join-Path $env:USERPROFILE '.aleph-keshev-update'
$projectBackupRoot = Join-Path $stateRoot $projectDigest

# 같은 프로젝트에 업데이트 도구가 두 번 동시에 돌지 않게 합니다(이전 판 도구와 같은 이름을 씁니다).
$mutex = New-Object Threading.Mutex($false, "Local\AlekovSelfUpdate_$projectDigest")
$locked = $false
try { $locked = $mutex.WaitOne(0) } catch [Threading.AbandonedMutexException] { $locked = $true }
if (-not $locked) { Refuse 'UPDATE_BUSY' '이 프로젝트에서 업데이트 도구가 이미 실행 중입니다. 먼저 실행한 창이 끝난 뒤 다시 실행하세요.' }
if ($faults -contains 'hold') { Start-Sleep -Seconds 8 }

# 2) 고정 목록의 파일마다 지금 상태를 읽습니다 (상위 폴더나 파일이 바로가기면 중단)
$pinByPath = @{}
$targets = @()
foreach ($pin in $Pins) {
  if ($pin.p -match '(^|/)\.\.(/|$)' -or $pin.p -match '^[/\\]' -or $pin.p -match ':' -or $pin.p -match '^student/') { Refuse 'UPDATE_UNSAFE_PATH' "도구 내부 목록에 이상한 경로가 있습니다: $($pin.p)" }
  $pinByPath[$pin.p] = $pin
  $full = [IO.Path]::GetFullPath((Join-Path $root $pin.p.Replace('/', '\')))
  if (-not $full.StartsWith($root + '\', [StringComparison]::OrdinalIgnoreCase)) { Refuse 'UPDATE_UNSAFE_PATH' "프로젝트 밖을 가리키는 경로입니다: $($pin.p)" }
  $dir = Split-Path -Parent $full
  while ($dir.Length -gt $root.Length) {
    if ((Test-Path -LiteralPath $dir) -and (IsReparse $dir)) { Refuse 'UPDATE_UNSAFE_PATH' "폴더가 바로가기(연결 지점)로 되어 있습니다: $dir`n원래 폴더로 되돌린 뒤 다시 실행하세요." }
    $dir = Split-Path -Parent $dir
  }
  $exists = $false; $raw = $Absent; $lf = $Absent
  if (Test-Path -LiteralPath $full -PathType Leaf) {
    if (IsReparse $full) { Refuse 'UPDATE_UNSAFE_PATH' "파일이 바로가기(연결 지점)로 되어 있습니다: $($pin.p)" }
    $bytes = [IO.File]::ReadAllBytes($full)
    $exists = $true; $raw = Sha256Bytes $bytes; $lf = LfHashBytes $bytes
  } elseif (Test-Path -LiteralPath $full) { Refuse 'UPDATE_UNSAFE_PATH' "파일 자리에 폴더가 있습니다: $($pin.p)" }
  $isNew = $exists -and ($raw -eq $pin.n -or $lf -eq $pin.n)
  $match = @{}
  foreach ($v in $FromVersions) {
    $o = [string]$pin.o[$v]
    if ($o -eq '') { $match[$v] = -not $exists } else { $match[$v] = $exists -and ($raw -eq $o -or $lf -eq $o) }
  }
  $known = $isNew -or @($FromVersions | Where-Object { $match[$_] }).Count -gt 0
  $state = if (-not $exists -and -not $known) { 'missing' } elseif (-not $known) { 'modified' } elseif ($isNew) { 'new' } else { 'old' }
  $targets += [pscustomobject]@{ p=$pin.p; full=$full; pin=$pin; n=$pin.n; exists=$exists; raw=$raw; isNew=$isNew; match=$match; state=$state }
}

# 3) 앱 서버가 이 폴더에서 돌고 있는지 확인 (다른 프로그램은 끄지 않습니다)
function AppState {
  $running = @(); $unknown = @(); $notes = @()
  $procs = @()
  try { $procs = @(Get-CimInstance Win32_Process -Filter "Name='node.exe'" -ErrorAction Stop) }
  catch { $unknown += '실행 중인 node 목록을 읽지 못했습니다(' + $_.Exception.Message + ')' }
  foreach ($proc in $procs) {
    $cmd = [string]$proc.CommandLine
    # 실행 명령을 읽지 못하면 이 프로젝트의 앱인지 알 수 없으므로, 상대 경로로 켠 앱과 같이 '확인 불가' 로 멈춥니다(#1856).
    if (-not $cmd) { $unknown += "node.exe (PID $($proc.ProcessId)) 의 실행 명령을 읽을 수 없어 이 프로젝트의 앱인지 확인하지 못했습니다(다른 사용자나 관리자 권한으로 실행된 프로그램일 수 있습니다)."; continue }
    if ($cmd.IndexOf($root, [StringComparison]::OrdinalIgnoreCase) -ge 0) { $running += "node.exe (PID $($proc.ProcessId)) 가 이 프로젝트를 실행 중입니다."; continue }
    if ($cmd -match '(^|[\s"''])src[\\/]server\.mjs') { $unknown += "node.exe (PID $($proc.ProcessId)) 가 상대 경로(src/server.mjs)로 앱을 실행 중이라 어느 폴더의 앱인지 확인할 수 없습니다." }
  }
  return @{ running=$running; unknown=$unknown; notes=$notes }
}
function RefuseIfRunning {
  $st = AppState
  if ($st.running.Count -gt 0) { Refuse 'UPDATE_APP_RUNNING' ("앱 서버가 아직 켜져 있습니다. 서버 창에서 Ctrl+C 로 끈 뒤 다시 실행하세요.`n" + ($st.running -join "`n")) }
  if ($st.unknown.Count -gt 0) { Refuse 'UPDATE_APP_STATE_UNKNOWN' ("이 프로젝트의 앱 서버가 켜져 있는지 확인하지 못했습니다. 켜 둔 앱 서버 창이 있으면 Ctrl+C 로 끈 뒤 다시 실행하세요.`n관리자 권한으로 켠 node 처럼 이 도구가 확인할 수 없는 프로그램이 있으면, 그 창을 닫거나 이 화면을 담당 강사에게 보여 주세요(이 도구는 다른 프로그램을 끄지 않습니다).`n" + ($st.unknown -join "`n")) }
  foreach ($n in $st.notes) { Say "참고: $n" }
}

# 4) 백업 기록 검사 (되돌리기 전에 모두 확인하고, 하나라도 어긋나면 쓰기 전에 거절)
$RecordRequired = @('schema', 'project', 'projectDigest', 'from', 'to', 'zipSha256', 'createdAt', 'state', 'files')
$RecordOptional = @('appliedAt', 'restoredAt', 'endedAt')
$States = @('prepared', 'applied', 'rolled-back', 'partial', 'restored')
function Damaged([string]$name, [string]$why) { Refuse 'RESTORE_BACKUP_DAMAGED' "백업 기록이 손상되었거나 완전하지 않습니다 ($name): $why`n백업 폴더는 지우지 말고 그대로 둔 채 담당 강사에게 알려 주세요." }
function ReadRecord($dirInfo) {
  $name = $dirInfo.Name
  if ($dirInfo.Attributes -band [IO.FileAttributes]::ReparsePoint) { Damaged $name '백업 폴더가 바로가기입니다' }
  if (-not (CheckPrivateAcl $dirInfo.FullName)) { Damaged $name '백업 폴더 권한이 본인 전용이 아닙니다' }
  $jsonPath = Join-Path $dirInfo.FullName 'backup.json'
  if (-not (Test-Path -LiteralPath $jsonPath -PathType Leaf)) { Damaged $name '기록 파일이 없습니다' }
  if (IsReparse $jsonPath) { Damaged $name '기록 파일이 바로가기입니다' }
  if ((Get-Item -LiteralPath $jsonPath).Length -gt 65536) { Damaged $name '기록 파일이 너무 큽니다' }
  try { $r = [IO.File]::ReadAllText($jsonPath, (New-Object Text.UTF8Encoding($false, $true))) | ConvertFrom-Json } catch { Damaged $name '기록 파일을 읽을 수 없습니다' }
  if ($null -eq $r -or $r -isnot [pscustomobject]) { Damaged $name '기록 형식이 아닙니다' }
  $keys = @($r.PSObject.Properties.Name)
  foreach ($k in $RecordRequired) { if ($keys -notcontains $k) { Damaged $name "필수 항목 없음: $k" } }
  foreach ($k in $keys) { if ($RecordRequired -notcontains $k -and $RecordOptional -notcontains $k) { Damaged $name "모르는 항목: $k" } }
  # PowerShell 7 은 날짜 문자열을 날짜형으로 읽으므로 ...At 항목만 날짜형을 허용합니다.
  foreach ($k in $keys) { if ($k -ne 'files' -and $r.$k -isnot [string] -and -not ($k -like '*At' -and $r.$k -is [datetime])) { Damaged $name "문자열이 아닌 항목: $k" } }
  if ($States -notcontains $r.state) { Damaged $name "모르는 상태: $($r.state)" }
  return $r
}
function IsThisToolRecord($r) {
  # 이전 판 도구(예: 0.2.11 → 0.2.13)가 만든 백업은 이 도구가 되돌리지 않습니다. 그대로 둡니다.
  return ($r.schema -eq $BackupSchema -and $r.to -eq $ToVersion -and $r.zipSha256 -eq $ZipSha256)
}
function ChangedPins([string]$from) { return @($Pins | Where-Object { [string]$_.o[$from] -ne $_.n }) }
function CheckRecordForRestore($dirInfo, $r) {
  $name = $dirInfo.Name
  if ($r.project -ne $root -or $r.projectDigest -ne $projectDigest) {
    Refuse 'RESTORE_WRONG_PROJECT' "이 백업은 다른 프로젝트 폴더에서 만든 것입니다.`n백업 대상: $($r.project)`n지금 폴더: $root"
  }
  if ($FromVersions -notcontains $r.from) { Damaged $name "출발판이 이 도구의 목록에 없습니다: $($r.from)" }
  $from = [string]$r.from
  $expected = ChangedPins $from
  $files = @($r.files)
  if ($r.files -isnot [array] -or $files.Count -ne $expected.Count) { Damaged $name "파일 목록이 $($expected.Count)개가 아닙니다 ($($files.Count)개)" }
  $seen = @{}
  $filesDir = Join-Path $dirInfo.FullName 'files'
  if (-not (Test-Path -LiteralPath $filesDir -PathType Container) -or (IsReparse $filesDir)) { Damaged $name '원본 파일 폴더가 없거나 바로가기입니다' }
  $plan = @()
  foreach ($f in $files) {
    if ($f -isnot [pscustomobject]) { Damaged $name '파일 항목 형식이 아닙니다' }
    $fk = @($f.PSObject.Properties.Name | Sort-Object)
    if (($fk -join ',') -ne 'after,before,p') { Damaged $name ('파일 항목의 키가 다릅니다: ' + ($fk -join ',')) }
    if ($f.p -isnot [string] -or $f.before -isnot [string] -or $f.after -isnot [string]) { Damaged $name '파일 항목 값이 문자열이 아닙니다' }
    if (-not $pinByPath.ContainsKey($f.p)) { Damaged $name "모르는 파일: $($f.p)" }
    if ($seen.ContainsKey($f.p)) { Damaged $name "같은 파일이 두 번 있습니다: $($f.p)" }
    $seen[$f.p] = $true
    $pin = $pinByPath[$f.p]
    $o = [string]$pin.o[$from]
    if ($o -eq $pin.n) { Damaged $name "이 출발판에서는 바뀌지 않는 파일입니다: $($f.p)" }
    if ($f.after -cne $pin.n) { Damaged $name "업데이트 뒤 해시가 공식 새 판과 다릅니다: $($f.p)" }
    $t = @($targets | Where-Object { $_.p -eq $f.p })[0]
    if (-not $t.exists -or $t.raw -ne $pin.n) {
      Refuse 'RESTORE_TARGET_CHANGED' "업데이트 뒤에 이 파일이 바뀌어서 자동으로 되돌릴 수 없습니다: $($f.p)`n직접 고친 내용을 지키기 위해 아무것도 바꾸지 않았습니다. 담당 강사에게 알려 주세요."
    }
    if ($o -eq '') {
      # 새 판에서 새로 생긴 제공 파일: 원본은 '없음' 이고 저장된 원본 파일도 없어야 합니다.
      if ($f.before -cne $Absent) { Damaged $name "새로 생긴 파일인데 원본 해시가 있습니다: $($f.p)" }
      $saved = Join-Path $filesDir $f.p.Replace('/', '\')
      if (Test-Path -LiteralPath $saved) { Damaged $name "새로 생긴 파일인데 원본 파일이 저장되어 있습니다: $($f.p)" }
      $plan += @{ full=$t.full; bytes=$null; expect=$Absent; undoBytes=[IO.File]::ReadAllBytes($t.full); undoHash=$pin.n; p=$f.p }
      continue
    }
    if ($f.before -notmatch '^[0-9a-f]{64}$') { Damaged $name "원본 해시 형식이 아닙니다: $($f.p)" }
    $saved = Join-Path $filesDir $f.p.Replace('/', '\')
    $d = Split-Path -Parent $saved
    while ($d.Length -gt $filesDir.Length) {
      if (-not (Test-Path -LiteralPath $d -PathType Container) -or (IsReparse $d)) { Damaged $name "원본 파일 폴더가 없거나 바로가기입니다: $d" }
      $d = Split-Path -Parent $d
    }
    if (-not (Test-Path -LiteralPath $saved -PathType Leaf) -or (IsReparse $saved)) { Damaged $name "원본 파일이 없거나 바로가기입니다: $($f.p)" }
    $savedBytes = [IO.File]::ReadAllBytes($saved)
    $savedHash = Sha256Bytes $savedBytes
    if ($savedHash -ne $f.before) { Damaged $name "원본 파일이 기록과 다릅니다: $($f.p)" }
    # 기록에 적힌 해시를 그대로 믿지 않고, 공식 출발판 원본(또는 그 CRLF 사본)인지 다시 확인합니다.
    if ($savedHash -ne $o -and (LfHashBytes $savedBytes) -ne $o) { Damaged $name "원본 파일이 공식 $from 제공 파일이 아닙니다: $($f.p)" }
    $plan += @{ full=$t.full; bytes=$savedBytes; expect=$savedHash; undoBytes=[IO.File]::ReadAllBytes($t.full); undoHash=$pin.n; p=$f.p }
  }
  return ,$plan
}

function SetRecordField($r, [string]$k, $v) {
  if ($r -is [System.Collections.IDictionary]) { $r[$k] = $v } else { $r | Add-Member -NotePropertyName $k -NotePropertyValue $v -Force }
}

# 5) 되돌리기 (-Restore)
if ($Restore) {
  $script:Result.mode = 'restore'
  if (-not (Test-Path -LiteralPath $projectBackupRoot)) { Refuse 'RESTORE_NOT_FOUND' "이 프로젝트 폴더로 만든 업데이트 백업이 없습니다.`n확인한 폴더: $root" }
  CheckPrivateDirectory $stateRoot 'RESTORE_BACKUP_DAMAGED'
  CheckPrivateDirectory $projectBackupRoot 'RESTORE_BACKUP_DAMAGED'
  $candidates = @(Get-ChildItem -LiteralPath $projectBackupRoot -Directory -Force | Where-Object { $_.Name -match '^[0-9]{8}-[0-9]{6}-[0-9a-f]{6}$' } | Sort-Object Name -Descending)
  if ($BackupId) { $candidates = @($candidates | Where-Object { $_.Name -eq $BackupId }) }
  $pick = $null; $record = $null
  foreach ($c in $candidates) {
    $r = ReadRecord $c
    if (-not (IsThisToolRecord $r)) {
      if ($BackupId) { Refuse 'RESTORE_OTHER_TOOL' "이 백업은 다른 판의 업데이트 도구가 만든 것입니다: $($c.Name)`n그 도구로 되돌리거나 담당 강사에게 알려 주세요. 백업 폴더는 지우지 마세요." }
      continue
    }
    if ($r.state -eq 'applied') { $pick = $c; $record = $r; break }
    if ($BackupId) { Refuse 'RESTORE_NOT_FOUND' "이 백업은 되돌릴 상태가 아닙니다 (상태: $($r.state)): $($c.Name)" }
    if ($r.state -eq 'partial') { Refuse 'RESTORE_BACKUP_DAMAGED' "이전 업데이트가 중간에 일부만 되돌려진 기록이 있습니다: $($c.Name)`n백업 폴더는 그대로 둔 채 담당 강사에게 알려 주세요." }
  }
  if (-not $pick) { Refuse 'RESTORE_NOT_FOUND' "되돌릴 수 있는 $ToVersion 업데이트 기록이 없습니다. 이 도구로 업데이트를 적용한 적이 없거나 이미 되돌렸습니다." }
  $script:Result.backupId = $pick.Name
  $script:Result.from = [string]$record.from
  $plan = CheckRecordForRestore $pick $record
  RefuseIfRunning
  $run = RunSwaps $plan 'restore'
  $metaError = ''
  if ($run.ok) {
    try { $record.state = 'restored'; SetRecordField $record 'restoredAt' ((Get-Date).ToString('o')); WriteBackupJson $pick.FullName $record } catch { $metaError = $_.Exception.Message }
    if ($metaError) { $run = @{ ok=$false; error=('백업 기록을 마무리하지 못했습니다: ' + $metaError); undone=(UndoSteps $plan) } }
  }
  if (-not $run.ok) {
    if ($run.undone) {
      FailAfterChange 'RESTORE_FAILED_ROLLED_BACK' ($run.error + "`n중간에 실패해서 되돌리기 전 상태($ToVersion)로 다시 맞춰 두었습니다. 백업은 그대로 있으니 잠시 뒤 다시 -Restore 를 실행하세요.") 3
    }
    FailAfterChange 'RESTORE_FAILED_PARTIAL' ($run.error + "`n일부 파일을 원래대로 맞추지 못했습니다. 백업 폴더는 지우지 말고 이 창을 캡처해서 담당 강사에게 보내 주세요.`n백업 폴더: $($pick.FullName)") 4
  }
  $script:Result.ok = $true; $script:Result.touched = $true; $script:Result.code = 'RESTORED'; $script:Result.changed = @($plan | ForEach-Object { $_.p })
  Say "[완료] 업데이트 전 상태($($record.from))로 되돌렸습니다. 되돌린 파일 $($plan.Count)개"
  Say '앱을 다시 켜려면: powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\start-alekov.ps1'
  Finish 0
}

# 6) 업데이트 (기본: 미리보기, -Apply: 적용)
$script:Result.mode = if ($Apply) { 'apply' } else { 'dry-run' }
$modified = @($targets | Where-Object { $_.state -eq 'modified' })
$missing = @($targets | Where-Object { $_.state -eq 'missing' })
Say "케셰브 시작 틀 업데이트 ($($FromVersions -join ' 또는 ') → $ToVersion)"
Say "프로젝트 폴더: $root"
if ($missing.Count -gt 0) {
  Refuse 'UPDATE_FILE_MISSING' ("제공 파일이 없어서 업데이트할 수 없습니다.`n" + (($missing | ForEach-Object { "  - $($_.p)" }) -join "`n") + "`n지운 파일이라면 git 으로 되살린 뒤 다시 실행하세요. 예: git checkout -- <파일 경로>")
}
if ($modified.Count -gt 0) {
  Refuse 'UPDATE_FILE_MODIFIED' ("직접 고친 제공 파일이 있어서 자동 업데이트를 멈췄습니다. 고친 내용을 덮어쓰지 않기 위해서입니다.`n" + (($modified | ForEach-Object { "  - $($_.p)" }) -join "`n") + "`n과제 코드는 student 폴더에만 두어야 합니다. 담당 강사에게 이 목록을 보여 주세요.")
}
if (@($targets | Where-Object { -not $_.isNew }).Count -eq 0) {
  $script:Result.ok = $true; $script:Result.code = 'ALREADY_LATEST'; $script:Result.from = $ToVersion
  Say "[완료] 이미 $ToVersion 입니다. 바꿀 파일이 없습니다."
  Finish 0
}
$from = ''
foreach ($v in $FromVersions) {
  if (@($targets | Where-Object { -not $_.match[$v] }).Count -eq 0) { $from = $v; break }
}
if (-not $from) {
  $detail = @()
  foreach ($t in $targets) {
    $which = @($FromVersions | Where-Object { $t.match[$_] })
    if ($t.isNew) { $which += $ToVersion }
    $detail += "  - $($t.p): " + ($which -join ', ')
  }
  Refuse 'UPDATE_UNKNOWN_VERSION' ("제공 파일들이 한 가지 공식 판으로 맞지 않아 어느 판인지 알 수 없습니다(일부만 바뀐 상태일 수 있습니다).`n" + ($detail -join "`n") + "`n담당 강사에게 이 목록을 보여 주세요.")
}
$script:Result.from = $from
$olds = @($targets | Where-Object { [string]$_.pin.o[$from] -ne $_.n })
if (-not $Apply) {
  $script:Result.ok = $true; $script:Result.code = 'DRY_RUN_READY'; $script:Result.changed = @($olds | ForEach-Object { $_.p })
  Say "지금 판: $from"
  Say "[미리보기] 바꿀 제공 파일 $($olds.Count)개:"
  foreach ($t in $olds) { if ($t.exists) { Say "  - $($t.p)" } else { Say "  - $($t.p) (새로 생기는 파일)" } }
  Say 'student 폴더, 내 문서, .git, 커밋, AI 연결 설정은 건드리지 않습니다.'
  $st = AppState
  foreach ($m in @($st.running + $st.unknown)) { Say "주의: $m 적용하기 전에 서버 창에서 Ctrl+C 로 꺼 주세요." }
  foreach ($n in $st.notes) { Say "참고: $n" }
  Say '적용하려면 같은 명령 끝에 -Apply 를 붙여 다시 실행하세요.'
  Finish 0
}
RefuseIfRunning

# 7) 공식 ZIP 받기와 확인
EnsurePrivateDirectory $stateRoot
$partial = $null
if ($ZipPath) {
  try { $zipFile = [IO.Path]::GetFullPath($ZipPath) } catch { Refuse 'UPDATE_ZIP_NOT_FOUND' "ZIP 경로를 읽을 수 없습니다: $ZipPath" }
  if (-not (Test-Path -LiteralPath $zipFile -PathType Leaf)) { Refuse 'UPDATE_ZIP_NOT_FOUND' "ZIP 파일이 없습니다: $zipFile" }
} else {
  $downloads = Join-Path $stateRoot 'downloads'
  EnsurePrivateDirectory $downloads
  $zipFile = Join-Path $downloads "alekov-starter-$ToVersion.zip"
  $haveGood = (Test-Path -LiteralPath $zipFile -PathType Leaf) -and -not (IsReparse $zipFile) -and ((Get-Item -LiteralPath $zipFile).Length -eq $ZipSize) -and ((Sha256File $zipFile) -eq $ZipSha256)
  if (-not $haveGood) {
    Say "공식 시작 틀을 내려받는 중입니다: $ZipUrl"
    $partial = Join-Path $downloads ('.download-' + [Guid]::NewGuid().ToString('N') + '.part')
    $script:OwnedTemps.Add($partial)
    try {
      [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
      Invoke-WebRequest -Uri $ZipUrl -OutFile $partial -UseBasicParsing -TimeoutSec 120
    } catch {
      Refuse 'UPDATE_ZIP_DOWNLOAD_FAILED' ("공식 시작 틀을 내려받지 못했습니다. 인터넷 연결을 확인하세요.`n학교망에서 막혔다면 포털에서 ZIP 을 직접 받은 뒤 -ZipPath 로 그 파일을 지정해 다시 실행하세요.`n원인: " + $_.Exception.Message)
    }
    if ((Get-Item -LiteralPath $partial).Length -ne $ZipSize -or (Sha256File $partial) -ne $ZipSha256) {
      Refuse 'UPDATE_ZIP_HASH_MISMATCH' '내려받은 파일이 공식 시작 틀과 다릅니다. 잠시 뒤 다시 실행하거나, 포털에서 직접 받아 -ZipPath 로 지정하세요.'
    }
    $zipFile = $partial
  }
}
if ((IsReparse $zipFile) -or (Get-Item -LiteralPath $zipFile).Length -ne $ZipSize -or (Sha256File $zipFile) -ne $ZipSha256) {
  Refuse 'UPDATE_ZIP_HASH_MISMATCH' "ZIP 파일이 공식 $ToVersion 시작 틀과 다릅니다. 다른 파일이거나 내려받는 중에 손상되었습니다.`n파일: $zipFile"
}
try { Add-Type -AssemblyName System.IO.Compression; Add-Type -AssemblyName System.IO.Compression.FileSystem } catch { Refuse 'UPDATE_POWERSHELL_RESTRICTED' 'ZIP 을 여는 기능을 불러오지 못했습니다. 담당 강사에게 알려 주세요.' }
$newBytes = @{}
$archive = [IO.Compression.ZipFile]::OpenRead($zipFile)
$zipProblem = ''
try {
  foreach ($t in $olds) {
    $entries = @($archive.Entries | Where-Object { $_.FullName -ceq ('on-client/' + $t.p) })
    if ($entries.Count -ne 1) { $zipProblem = "ZIP 안에서 파일을 하나로 특정할 수 없습니다: $($t.p)"; break }
    $ms = New-Object IO.MemoryStream
    $es = $entries[0].Open(); try { $es.CopyTo($ms) } finally { $es.Dispose() }
    $bytes = $ms.ToArray()
    if ((Sha256Bytes $bytes) -ne $t.n) { $zipProblem = "ZIP 안의 파일이 예상한 새 판과 다릅니다: $($t.p)"; break }
    $newBytes[$t.p] = $bytes
  }
} finally { $archive.Dispose() }
if ($zipProblem) { Refuse 'UPDATE_ZIP_ENTRY_INVALID' $zipProblem }
if ($partial -and $zipFile -eq $partial) {
  # 검증한 내려받기 파일을 다음 실행을 위해 보관합니다(기존 파일은 지우지 않고, 없을 때만 둡니다).
  $keep = Join-Path $downloads "alekov-starter-$ToVersion.zip"
  try { if (-not (Test-Path -LiteralPath $keep)) { [IO.File]::Move($partial, $keep) } } catch {}
}

# 8) 백업 (프로젝트 밖, 본인만 열 수 있는 폴더)
EnsurePrivateDirectory $projectBackupRoot
$backupId = (Get-Date).ToString('yyyyMMdd-HHmmss') + '-' + ([Guid]::NewGuid().ToString('N').Substring(0, 6))
$backupDir = Join-Path $projectBackupRoot $backupId
$script:Result.backupId = $backupId
$record = [ordered]@{
  schema=$BackupSchema; project=$root; projectDigest=$projectDigest; from=$from; to=$ToVersion
  zipSha256=$ZipSha256; createdAt=(Get-Date).ToString('o'); state='prepared'
  files=@($olds | ForEach-Object { [ordered]@{ p=$_.p; before=$_.raw; after=$_.n } })
}
$plan = @()
try {
  if (Test-Path -LiteralPath $backupDir) { throw "같은 이름의 백업 폴더가 이미 있습니다: $backupDir" }
  [void][IO.Directory]::CreateDirectory($backupDir, (PrivateDirectorySecurity))
  if ((IsReparse $backupDir) -or -not (CheckPrivateAcl $backupDir)) { throw '백업 폴더 권한이 본인 전용으로 설정되지 않았습니다.' }
  [void][IO.Directory]::CreateDirectory((Join-Path $backupDir 'files'))
  foreach ($t in $olds) {
    if (-not $t.exists) {
      if ((CurrentHash $t.full) -ne $Absent) { throw "확인한 뒤에 파일이 생겼습니다: $($t.p)" }
      $plan += @{ full=$t.full; bytes=$newBytes[$t.p]; expect=$t.n; undoBytes=$null; undoHash=$Absent; p=$t.p }
      continue
    }
    $saved = Join-Path $backupDir ('files\' + $t.p.Replace('/', '\'))
    [void][IO.Directory]::CreateDirectory((Split-Path -Parent $saved))
    $orig = [IO.File]::ReadAllBytes($t.full)
    if ((Sha256Bytes $orig) -ne $t.raw) { throw "확인한 뒤에 파일이 바뀌었습니다: $($t.p)" }
    $fs = New-Object IO.FileStream($saved, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
    try { $fs.Write($orig, 0, $orig.Length); $fs.Flush($true) } finally { $fs.Dispose() }
    if ((Sha256File $saved) -ne $t.raw) { throw "백업 파일 확인 실패: $($t.p)" }
    $plan += @{ full=$t.full; bytes=$newBytes[$t.p]; expect=$t.n; undoBytes=$orig; undoHash=$t.raw; p=$t.p }
  }
  WriteBackupJson $backupDir $record
} catch {
  Refuse 'UPDATE_BACKUP_FAILED' ("백업을 만들지 못해 업데이트를 시작하지 않았습니다.`n원인: " + $_.Exception.Message)
}

# 9) 적용 — 파일 교체와 최종 기록 쓰기를 한 묶음으로 봅니다. 기록을 못 쓰면 바꾼 파일을 모두 되돌립니다.
$run = RunSwaps $plan 'apply'
if ($run.ok) {
  $metaError = ''
  try { $record.state = 'applied'; $record.appliedAt = (Get-Date).ToString('o'); WriteBackupJson $backupDir $record } catch { $metaError = $_.Exception.Message }
  if ($metaError) {
    $record.Remove('appliedAt')
    $run = @{ ok=$false; error=('백업 기록을 마무리하지 못했습니다: ' + $metaError); undone=(UndoSteps $plan) }
  }
}
if (-not $run.ok) {
  $record.state = if ($run.undone) { 'rolled-back' } else { 'partial' }
  $record.endedAt = (Get-Date).ToString('o')
  $recordNote = ''
  try { WriteBackupJson $backupDir $record } catch { $recordNote = "`n(실패 기록도 쓰지 못했습니다. 원본 백업 파일은 그대로 있습니다: $backupDir)" }
  if ($run.undone) {
    FailAfterChange 'UPDATE_FAILED_ROLLED_BACK' ($run.error + "`n중간에 실패해서 바꾼 파일을 모두 원래대로 되돌렸습니다. 프로젝트는 업데이트 전과 같습니다. 잠시 뒤 다시 실행하고, 반복되면 담당 강사에게 알려 주세요." + $recordNote) 3
  }
  FailAfterChange 'UPDATE_FAILED_PARTIAL' ($run.error + "`n일부 파일을 원래대로 되돌리지 못했습니다. 원본 백업은 여기 있으니 지우지 마세요: $backupDir`n이 창을 캡처해서 담당 강사에게 보내 주세요." + $recordNote) 4
}
$script:Result.ok = $true; $script:Result.touched = $true; $script:Result.code = 'UPDATED'; $script:Result.changed = @($olds | ForEach-Object { $_.p })
Say "[완료] $from 에서 $ToVersion 으로 업데이트했습니다. 바꾼 제공 파일 $($olds.Count)개"
Say "백업 번호: $backupId (되돌리려면 같은 폴더에서 -Restore 로 실행)"
Say '다음 순서:'
Say '  1) 앱 다시 켜기: powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\start-alekov.ps1'
Say "  2) 확인: 같은 명령을 -Apply 없이 다시 실행하면 '이미 $ToVersion 입니다' 가 나와야 합니다"
Say '  3) git status 로 바뀐 제공 파일을 확인하고, 평소처럼 커밋하고 올리기'
Finish 0
