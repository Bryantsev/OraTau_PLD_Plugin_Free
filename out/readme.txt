OraTau PLD Plugin Free

OraTau PLD Plug-in is Allround Automations PL/SQL Developer plugin. The plugin aims to higher simplification and increase of productivity and comfort while working with RDBMS Oracle via PL/SQL Developer.

Key features
- "OraTau Logon" offers an alternative way to view user list available for logon. Comparing with the default approach, it features the following options: 
	o You can rearrange users in the list into different types and groups, depending on their function. You can easily customize groups and types; 
	o You can filter, group and sort user records by any sign; 
	o You can hide unnecessary columns in the list; 
	o Much more attractive color and visual appearance of the list; 
	o Added a vertical scrollbar if the entire user list doesnТt fit the screen. With the default approach you have to click "moreЕ" over and over which may be irritating if you often need to switch between users; 
- "OraTau Script Execute" allows running a script on behalf of many users with a single operation. Moreover, a script can be executed both in the PL/SQL Developer Command Window and directly in an Oracle DB. This tool is irreplaceable, if you have many similar users or Oracle schemes and you need to modify all of them at once. 
- "OraTau Quick Query". If you often need to take values from different source tables (directories, customer lists etc.) while writing a query or a script, the Quick Query tool is for you! With Quick Query you can build a set of frequently used queries and run them with a hot key at any time. Then, upon a script execution, you simply double-click the query result cell to paste the required value into the resulting text and with a single key press paste it to the PL/SQL Developer editor window or copy it to the clipboard. 
- "OraTau Save As". The default approach to saving provided by PL/SQL Developer implies either an explicit saving of a file by a user (who needs to specify the file name and the destination folder), or an implicit saving by means of the Recovery mechanism (depending on the settings, the file will be saved on execution or by timer). Both ways are inconvenient. The first approach to saving doesnТt allow you to skip the filename part, and this can be really annoying, as not every script actually needs to be named. The implicit character of the second approach is not any more convenient either. Where files are actually saved? What format are they saved in? This is all rather unclear. Additionally, with this approach youТre partially losing a control over the saving process (you canТt just press Ctrl+S and save a script at any given moment). "OraTau Save As" makes it much easier to use the first approach as it automatically pops up a saving dialog with a wild-card based, auto-generated filename already suggested. You can save this temporary file into the pluginТs temp folder or use the default save dialog of PL/SQL Developer to save the file prior to editing (the default filename is the name of the DB object being edited). You can also save spec and body of types and packages as separate files in addition to the main file of a package or a type (optionally). 
- "OraTau Save". This is an alternative to the standard Save operation of PL/SQL Developer. If you save a previously unsaved file with this tool, it invokes the "OraTau Save As" dialog and lets you choose the name of the file. It also includes the functionality to save spec and body of packages and types as separate files in addition to the main file of a package or a type (optionally). You can additionally enable the backup files history option.
- "OraTau Comment". You can comment/uncomment a selected text with line comments (--) with the same hotkey/action. A comment is added to the minimum position of the first visible symbol of every line in a selected text. This means that upon any subsequent reformatting of the code, each commented line shifts to the right to the length of the comment string (--) only.

System requirements: PL/SQL Developer version 7.1.0 or later

History
Legend: [+] - added; [-] - removed; [#] - changed; [*] - fixed

[2014-08-13]
Version: 1.5
[#] License is changed to Free Version :)

[2011-03-19]
Version: 1.4 (requires translate)
[#] обновление настроек и данных происходит автоматически, если они были изменены в другом экземпл€ре PL/SQL Developer;
[#] пункт меню "OraTau / Refresh Data and Settings" удален;
[#] выбранные строки комментируютс€, если хот€ бы в одной непустой строке из выбранных нет комментари€, а не инвертируют состо€ние комментари€ дл€ каждой строки отдельно.

[2011-01-19]
Version: 1.3.2
[*] Fixed a bug that appears when you add the first user

[2011-01-16]
Version: 1.3
[+] A "visibility" parameter is added for a user. If it is set to False and the "Show all users" option is disabled (see the "Logon", the "Fast Logon" and the "Database script execution" dialogs), the user isnТt displayed in the list. This is handy if you need to hide users you donТt use often;
[+] The "OraTau / Directories / Import users" menu command is added. It opens the "Import users" window;
[+] The "Import users" dialog now supports importing a PL/SQL Developer submenu in the format ">submenu". New submenu items are added as user groups. If a group with such name already exists, it will be used automatically;
[+] The "Generate spec and body file" setting is added. If it is turned on, a "spec and body" file is generated basing correspondingly on body and spec files when saving a spec or a body file of a type or a package;
[#] Now PL/SQL Developer windows do not open while saving spec and body files separately. Utf8 encoding work is fixed (some regional symbols may have been replaced with ??? symbols in saved files);
[#] The appearance of the "OraTau Save As" window has been changed. The option "additionally save package/type spec and body as separate files" has been removed. Now the value from the options window is taken;
[#] It is possible to open several temporary and backup files simultaneously;
[*] While starting PL/SQL Developer, the save dialog is no longer shown for windows that havenТt been saved before exit or due to some failure. This sometimes led to unexpected failures and interrupted window opening process;
[*] Minor improvements and bug fixes

[2010-06-22]
Version: 1.2
[+] You can store the file changes history (backup files) now (see Settings Ц Files). With this option turned on, a file is preliminarily copied to the _history folder before any changes are saved;
[+] New command "Open a backup file" in the File menu. With it you can open a backup file of the currently opened file;
[#] "OraTau Save As" now takes the default folder from the PL/SQL Developer settings dialog, the "Preferences Ц Files Ц Directories" section;
[#] Pressing Enter in the filename and tmp-filename editing windows of the "OraTau Save AsЕ" dialog corresponds to clicking the "Save As" and the "Save tmp-file" buttons respectively;
[*] Fixed a "Comment" command bug: if the cursor (the selected text) was located further than 65535 symbols from the beginning, a line with 65535th symbol got commented

[2010-05-30]
Version: 1.1
[+] Added OraTau Comment operations. Comment or uncomment text with a single hotkey while keeping the initial formatting of a code;
[+] A new "user groups always expanded" option is added to the Settings dialog, the Logon tab. The option is on by default. Turning this off, you will be able to collapse user groups. Also, the only expanded group on start up will be the one with the current user;
[+] The new "Open Folder" button is added to the "Temporary file" section in the "OraTau Save As" dialog. Click this button to open the temporary folder in an Explorer window;
[#] Removed the version info from the name of the PL/SQL Developer internal interface plugin. Therefore you will need to add buttons onto the toolbar again

[2010-05-11]
Version: 1.0
[+] the 1st release of OraTau PLD Plugin

Contacts
Latest news and updates: http://www.oratau.com/oratau_pld/
Please send us your feedback and suggestions on functionality, and also bug reports to our e-mail: support@oratau.com or through internet page http://www.oratau.com/feedback.php

Copyright © 2014 Bryantsev Alexander