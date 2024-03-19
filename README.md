# cashgigs
_A simple key remapper for Windows._

## What is cashgigs
I love mice with millions of buttons but I hate the software that runs them. I've tried heaps of them - regardless of brand and without exception, they're all massive chunks of unresponsive bloatware. I don't think this is in dispute.  

cashgigs tries to be considerably simpler and more lightweight. Here's what it does:
- Remap keys in the application you're using without having to leave that application
- Record and play macros[^1]

Here's what it doesn't:
- come in an 800mb Electron package
- slurp up 2gb[^2] of your RAM when it's doing nothing
- start itself with windows 
- automagically save profiles into your _CASHGIGS UBERGAMER PROFILE CLOUD ACCOUNT_
- control your RGB
- send telemetry to me in order to improve your experience™

## QUICK START GUIDE™
Download cashgigs from [Releases](https://github.com/jade-doggerel/cashgigs/releases).  
### Before you start
cashgigs works with both keyboards and mice, but it can't discern between the two. As such, if you're using this with an MMO mouse like me, I advise using the software that came with your mouse to map the thumb buttons to keys that don't get pressed in normal use - mine are mapped to `F13` - `F24`, which don't exist on most keyboards.  
Most mice I have used have an "on-board memory profile" - save your keys in there and then uninstall the proprietary software.
### To remap a key:
1. Focus the window you want the remapping to work in[^3].
2. Press `Win + Esc`.
3. Press the key you want to remap.
4. Press the key you want to remap to.
5. Done!

### To record a macro:
1. Focus the window you want the macro to work in.
2. Press `Win + Shift + Esc`.
3. Press the key you want to trigger the macro.
4. Tap out your macro.
5. Press the key you pressed in step 3 again to [_LOCK IT IN_](https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQh-ShAviPoo1kkzEsn0QoKg7C4fFPqC-m3tzkaYxhNafV0Zut4).
6. Done!

### Other stuff:
- Press `Win + Q` to restart cashgigs.
- Your remappings are stored in `grogan.ini`. Edit them or remove them from there if you break something. Make backups of it. Share it with your friends. Upload it to your _CASHGIGS UBERGAMER PROFILE CLOUD ACCOUNT_.
- To quit cashgigs, right click on the tray icon (a little keyboard) and click 'Exit'.

## About cashgigs
It's pretty rudimentary. It is written in [AHK](https://www.autohotkey.com/docs/v2/) which is literally made for exactly this purpose - I'm surprised I couldn't find someone else who had already done this (admittedly I don't think I looked super hard).  
I'm not very experienced with low-level programming, so please go ahead and make pull requests.  
It's released under MIT so do whatever with it, though there's probably not too much point for a program that's only 100 lines long.  
cashgigs only works in Windows.

## `//TODO`
- refactor everything
- GUI
- Add options
  - toggle: autosave ini changes
  - toggle: apply persistent hotkeys 
  - ini file to use (profile)
  - toggle: enable creating new macros/hotkeys 
  - sounds toggle/sounds customisation 
  - toggle: windows notifications
  - save remaps as scancodes or key names 
  - trigger on wildcard modifiers toggle
- implement support for [custom QMK keycodes](https://github.com/qmk/qmk_firmware/blob/master/docs/feature_programmable_button.md)
- better icons
- Make script keys (e.g. `Win + Esc`) remappable in `grogan.ini`
- Backup ini file on startup
- Suspend all hotkeys on a (suspend exempt) hotkey
- investigate delays for macros?

## why is it called cashgigs
cashgigs is an acronym for Crate Armoury Synapse HUB-G iCUE Gaming Software.

[^1]: Macro support is still a little sketchy and may not work great in games.
[^2]: On my computer, cashgigs uses about 2mb of memory.
[^3]: If you want it to work in _all_ applications, focus the desktop instead of a window.  