# Due to the reason that adb forward is not stable with emulator,
# use this method to debug:
#
# 1. launch the emulator (note the "-serial pty" arguments in that script):
#    ./run-emulator.sh
#
# 2. find and remember the pty name in the emulator output, such as:
#    "char device redirected to /dev/pts/2"      # /dev/pts/2 in this case
#
# 3. attach the process in target (must be ttyS2 here):
#    adb shell gdbserver /dev/ttyS2 --attach ${pid}
#
# 4. source this script with:
#    source run-gdb.sh app_process32 /dev/pts/2  # java app
#    source run-gdb.sh netd /dev/pts/2           # native

gdbclient $*
