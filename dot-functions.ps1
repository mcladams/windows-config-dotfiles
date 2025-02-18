# dot-functions.ps1
# source this in the nomal way to use the functions and make sure to add to $PROFILE

# Recursively take ownership and set owner with full permissions
function Own-Full-Perms {
    param ( [string]$_path )

    takeown /F "$_path" /R /D Y /SKIPSL >$null 
    icacls "$_path" /grant:r ${env:USERNAME}:F /T /L /C /Q
}

# Frequent robocopy options
function robosync { robocopy $args /E /ZB /SJ /SL /COPYALL /DCOPY:DATE /MT /R:1 /W:0 /NS /NC /NFL /NDL /ETA }
function robosync-noown { robocopy $args /E /ZB /SJ /SL /COPY:DAT /DCOPY:DAT /MT /R:1 /W:0 /NS /NC /NFL /NDL /ETA }
function robosync-purge { robocopy $args /E /PURGE /ZB /SJ /SL /COPYALL /DCOPY:DATE /MT /R:1 /W:0 /NS /NC /NFL /NDL /ETA }
function zls { zfs.exe list -o name,used,available,referenced,overlay,canmount,mounted,driveletter,mountpoint  }
