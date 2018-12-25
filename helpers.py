import os


def write_pid(path):
    # flag_overwrites = (os.O_CREAT | os.O_EXCL | os.O_WRONLY)
    def opener(path, flags):
        return os.open(path, flags, mode=0o644)

    with open(path, 'w', opener=opener) as outfile:
        # According to the FHS 2.3 section on PID files in /var/run:
        #
        #   The file must consist of the process identifier in
        #   ASCII-encoded decimal, followed by a newline character. For
        #   example, if crond was process number 25, /var/run/crond.pid
        #   would contain three characters: two, five, and newline.
        print(os.getpid(), file=outfile)
