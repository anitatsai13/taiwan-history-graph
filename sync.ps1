# 把 Downloads 的工作檔同步到這個部署 repo。
# 用法：.\sync.ps1  （在 repo 目錄下執行）

$ErrorActionPreference = "Stop"
$src  = "C:\Users\anita\Downloads"
$repo = $PSScriptRoot

$map = @(
  @{ from = "臺灣史記憶關係圖_v7.html";             to = "graph.html"     }
  @{ from = "臺灣史心智圖.html";                     to = "mindmap.html"   }
  @{ from = "臺灣行政區劃演變地圖.html";             to = "admin-map.html" }
  @{ from = "臺灣史記憶關係圖_資料.md";              to = "data.md"        }
  @{ from = "臺灣史記憶關係圖_右鍵編輯功能規劃.md";  to = "edit-plan.md"   }
  @{ from = "中國與東亞史記憶關係圖.html";           to = "cn-graph.html"  }
  @{ from = "中國與東亞史_資料.md";                  to = "cn-data-v3.md"  }
  @{ from = "中國與東亞史_資料_第四冊.md";           to = "cn-data-v4.md"  }
)

foreach ($m in $map) {
  $f = Join-Path $src $m.from
  if (-not (Test-Path $f)) { Write-Host ("跳過（找不到）：" + $m.from); continue }
  Copy-Item $f (Join-Path $repo $m.to) -Force
  $kb = [math]::Round((Get-Item $f).Length / 1KB)
  Write-Host ("同步 " + $m.to + "　←　" + $m.from + "　(" + $kb + " KB)")
}

Write-Host ""
Write-Host "完成。接著："
Write-Host "  git add -A; git commit -m '<改了什麼>'; git push origin main"
