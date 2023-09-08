# Revision Finder

**v0.1.0**

This application lists the last 30 Wikipedia revisions from a chosen article. These revisions are
displayed using an Android GUI. 

This application uses MediaWiki's API to request this information in a JSON formatted file. The file
is then decoded to a map which is then changed to a Revision object. The UI is a basic layout of a
search bar and prompt at the top center of the application and returns two columns of information;
one with the editor's username and the other with the time stamp of the edit. A user-agent heading
is also used to allow the program to interact with Wikipedia safely, and to identify the program in
the requests.

## User-Agent Heading
'Revision Reporter/0.1 (http://www.cs.bsu.edu/~pvg/courses/cs222Fa22; nmmay@bsu.edu)'

This project was a collaboration between Noah May and Jamison Tucker.
