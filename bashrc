#
# history is kept in two files:
# .bash_histry - basically (reverse-)i-search buffer with no duplicates to keep it fast
# .bash_time_history - detailed entries with date, time and the time a command took
#                      it is kept forever (append only)
#
history_hook()
{
	local history_ret="$?"
	local history_cur="$(history 1)"
	test -n "${history_last}" -a "${history_last}" != "${history_cur}" && echo -n "${history_ret} ${history_cur}" | gawk '
BEGIN {
	endtime = systime();
	mintimeinterval = 1;
	historyfile = ENVIRON["HOME"] "/.bash_time_history";
}

{
	retcode   = $1;
	histid    = $2;
	starttime = $3;
	command   = substr($0, index($0, $4));
}

END {
	date = strftime("%Y-%m-%d", starttime);
	if (endtime - starttime >= mintimeinterval)
		time = strftime("%H:%M:%S", starttime) strftime("-%H:%M:%S", endtime);
	else
		time = strftime("%H:%M:%S", starttime);
	if (retcode == 0) {
		printf("\033[02;33m%s \033[00;02;36m%s\033[00m\n", time, command);
		printf("%s %s %s\n", date, time, command) >> historyfile;
	} else {
		printf("\033[02;33m%s \033[00;02;31m%s # %d\033[00m\n", time, command, retcode);
		printf("%s %s %s # %d\n", date, time, command, retcode) >> historyfile;
	}
}
'
	history_last=${history_cur}
}
HISTCONTROL=erasedups:ignorespace
HISTTIMEFORMAT="%s "
PROMPT_COMMAND=history_hook

HISTSIZE=50000
HISTFILESIZE=2000000
