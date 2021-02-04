 Hi everyone,

I just wanted to share my custom 'Open in VLC' command:

    cmd.exe /c "start vlc.exe "sftp://!U:!P@!@:!/!""


Options > Preferences > Commands. Add. Local Command. Check 'Use remote files'. Set to keyboard shortcut Ctrl+1 (a matter of preference).

Edit: Don't forget to add your path to VLC to PATH in your System Environment Variables!

Cheers
