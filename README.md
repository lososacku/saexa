# saexa

CLIPS:
- tools:
	- C tool-chain
	- CMake
	- curl-lib (installed)
- building:
	- run 'cmake CMakeLists.txt'
	- make
Scheme:
- install from DrRacket from racket-lang.org
Prolog:
- install XSB from http://xsb.sourceforge.net
- build the pcurl extension (this part is a bit ugly)
	- at the to of pcurl.c are two commented out prolog consult commands; one looks like this:
		- consult(pcurl, [cc_opts('-O2 -I/Users/sparrow/XSB/emu -I/Users/sparrow/XSB/config/i386-apple-darwin13.3.0')](#)).

	- this needs to be changed to work with the local XSB paths. Just launch xsb and issue the command, it should compile and produce the extension
	- N.B. XSB is a extraordinarily finicky about where it is and how it's launched. The upshot is that on \*nix systems a symlink won't work. It's necessary to use the entire path each time.
Mongdodb
- install from mongodb.org
- create a db called 'meteor'
Meteor:
- install from meteor.com
- before meteor is launched, the following needs to be exported:
	- MONGO\_URL=mongodb://localhost:27017/meteor
	- (if this doesn't exist, it will run with a meteor-local instance and won't work)

Firing it up:
- launch racket first (prolog and clips depend on it)
	- run saexa/projects/racket-server/server.rkt
- launch clips (from saexa/projects/clips-polling)
	- ../CLIPS/clips
	- (load "../clips-exposure/classes-modules.clp")
	- (load "polling.clp")
	- (reset)
	- (run)
- launch prolog (from saexa/projects/prolog-polling)
	- \<path to\>/XSB/config/\<local dir\>/bin/xsb
	- [polling].
- launch meteor (from saexa/projects/frontend)
	- meteor

And bang away...

There's a lot of fast moving parts...but after a couple (hundred) times you get used to it ;-)
