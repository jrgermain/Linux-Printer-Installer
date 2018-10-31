# qu-printing

This shell script installs Quinnipiac's new printers on a Linux or macOS machine. You can fork this if you want to make an installer for any printer that uses PPD drivers.

### Why?

While we have packaged macOS and Windows installers, we don't have installers available for Linux or older versions of Mac OS X.

### How?

I made a shell script that uses the `lpadmin` command to install the printers. The official Mac installer uses the same commands.

### Is it free?

Yes. Tuition is expensive enough as it is. This script is also free as in freedom; do whatever you want with it!

### How do I use it?

Run the shell script normally; in a terminal, type ` /dir/qu-printing.sh ` where ` dir ` is the directory the script is in.

For example, if the file is in your Downloads folder, run `~/Downloads/qu-printing.sh` and follow all on-screen prompts.
