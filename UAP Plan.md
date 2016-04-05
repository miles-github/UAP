# UAP
Ultimate Audio Player
_A Learning Experience in Swift_

We are going to be designing and programming the Ultimate Audio Player. Some of the features we will incorporate include:
- Support for Music, Books and Podcasts
- Play from the Cloud, iOS (iTunes) and App storage
- Clearly Display title, artist, artwork and other meta data
- Support for a dark mode for nighttime
- Control playback using gestures
- Watch controls
- Auto bookmarking on long files
- Cloud meta storage
- Download from web / RSS


Implementation
- Basic
  + Support for Audible, Music, Books, Podcast
  + Play / Pause / Skip / FF - buttons
  + Minimal file selection - iOS and App
  + Display currently playing

- Distributable
	Gestures
	Display Artwork / metadata
		Dark mode
	File Selection
		iOS/App, Playlist, Genre, Artist, Album, file
	Speed Control

- Enhanced
	Watch controls
	Multiple UIs - Dark, Light, Ambient
	Customize Displays
	AirPlay

- Advanced
	Export / Send to...
	Download from web
	Auto bookmark
		select bookmark
	Playlist management
	Cloud meta storage


Functions
- Select from iOS or app media Libraries
	Playlist, Genre, Artist, Album, file
- Select from streaming services / APIs
- Watch controls
- Download Podcast from RSS
- Export / Send to...
- Download from web
- Auto bookmark
	@ pause, start/stop, automatic timed intervals (eg every 15 min)


User Interface
- Dark for driving
- Light
- Auto adjust for ambient light
- Adjust display size of text
	scroll text
- Display artwork
- Display metadata
	display details - alternate screen
	Customize
	Lyrics
- Display playlist / next song
- Display bookmarks
- Customize display columns
	In playlists, Genre, Artist, Album
- Playlist Management
	Create
	Modify
	Add
	Mix iOS & App media?
	Display while playing


Features
- AirPlay
	Multiple AirPlay
- Open Source Audio Transmission
- Broadcast media to iOS
- Shuffle On/Off
- Repeat On/Off
- Speed control
- Gestures
	Edge swipe
	1, 2, 3 Finger swipes 4 directions
	tap, double tap – 1-3 fingers
	shake
	Functions
	-Play
	-Pause
	-Skip/Reverse x seconds
	-Volume
	-Next Chapter / Track
	-playback speed
- Gesture training
	audio training
	remember gestures used, train on less
- Tags
- Storage Management
	


Backend
- Support Apple internal media (iPod library)
	e.g. music player
	Audible, Music, Books, Podcast
- Support app embedded media
- Accumulate metadata
	time listened to
	time skipped over
	how often stop listening to a podcast
	Genre / band listened too – on a time basis
- Usage feedback
	Popup declaring this info will be transmitted to us
	Gestures used and functions activated
	Customization
	How often used
	Media type played – file length, music, audiobook, podcast
- Cloud meta storage
	iCloud, Dropbox, Box, OneDrive, Google Drive, Amazon
	Playlists
	Bookmarks
	Play history
	Book stopped at


Architecture
- Media Class
	Handles iPod Library file, App Library File,
	Local Network Files
	Cloud files
	Stream commercial API - e.g. Spotify
	IMPLEMENTATION
	- Media
	- Play function
	- Record
- Storage
	iPod Library
	App Library
	Local Network
	Cloud
- User Interface
	Display
	- Auto Brightness
	Buttons
	Gestures
	Speech to Text
	Playlist
- Audio Player
	play, pause, speed, skip
	AirPlay & Equivalent
- Meta Data Handling
	Search
	- Spotlight
	Cloud
	Player history
- Playlist
	Add, Remove, Move, Rename
- Social
	Post / Unpost
	Authentication
- AI
	Recommendation
	AI determined media preference
	Media Management
- Web / Network
	RSS Handling (Podcast)
	HTTP Handling (Safari API)
	Download
