# Radiology-Efficiency
Repo for PACS efficiency configurations

^ is Ctrl
+ is Shift
Send("{Blind}^") could be used to reactivate ctrl down (so it doesn't need to be pushed again)

Mapping to Ctrl & a instead of ^a will allow chaining multiple commands together with ctrl held.
If using ^a, the Ctrl will be undone with any "Send" commands.
But, this disables the native command! In this case, selecting all with Ctrl+A will never work

## Dependencies

Dependencies are in the `libraries` directory.

- https://github.com/Descolada/OCR

Capture2Text

## Shortcuts

Capture2Text for prior
```
C:\Users\B909907\OneDrive - Kaiser Permanente\@Tyler\Efficiency\Applications\Capture2Text\Capture2Text_CLI.exe --clipboard --screen-rect "3200 95 4363 123"
```