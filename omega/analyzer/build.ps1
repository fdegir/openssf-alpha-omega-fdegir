param(
    [Parameter(Mandatory=$false)]
    [bool]
    $force = $false
)

try
{
    $version = (Select-String -Path Dockerfile -Pattern 'LABEL Version="(.*)"').Matches.Groups[1].Value
    
    if ($force) {
        docker build --cpuset-cpus 0-1 -t openssf/omega-toolshed:$version . -f Dockerfile --build-arg CACHEBUST=$(date -Format o)
    } else {
        docker build --cpuset-cpus 0-1 -t openssf/omega-toolshed:$version . -f Dockerfile
    }
}
catch
{
    Write-Host "Error running build."
}
