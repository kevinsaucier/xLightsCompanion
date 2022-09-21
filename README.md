# xLights Companion

This is a very basic attempt to help with layout management in xLights.  All written in PowerShell (minus the batch file to start it).  It relies on Windows Forms and is written in a scripting language so it's not the quickest, but it seems to work.

Quick overview:

- There are a few parameters you can set within the top 30 or so lines of xLights-Main.ps1.  If you don't need to change them, you probably shouldn't.  

1. Upon opening, you'll need to choose your show folder.  DO NOT POINT THIS AT YOUR PRODUCTION SHOW FOLDER!  Make a copy of the xlights_rgbeffects.xml and xlights_networks.xml files and place them in a folder (I use a folder called 'Test Layout' under the xLight Companion script folder).  xLights Companion does not (currently) mess with the networks file, but having it there will let you run xLights later and test the new config.

2. Once you choose your show folder, xLights Companion will then make a backup copy of your xlights_rgbeffects file into a 'Backups' subdirectory of the xLights Companion script folder.  

3. You'll then be prompted to Sync xLights to the Repository.  xLights Companion will basically make a copy of all Models, Model Groups, and Views (used for sequencing) currently in the xLights_rgbeffects file into the xLightsCompanion.xml file.  This can be used to completely restore xLights (that code isn't written yet) but, more importantly, it is used to add/remove models from layouts.

4. As part of the Sync, you can choose to sync everything from xLights or only certian models/groups/views.  I recommend sync'ing everything the first time.  You can also choose to overwrite existing models (there won't be any the first time) but this is useful for subsequent sync's.

5. Once the initial sync is complete, you can choose a layout to work with.  A number of default layouts are created automatically but you can add/remove additional layouts as necessary.

6. At this point, you can either sync xLights to the layout or you can move models from the Repository into the layout.  When just getting started, it's easier to just move models from the Repository.  Once you have a number of layouts customized and you want to pull specific models from your working copy of xLights into your layout, it makes more sense to sync from xLights to the layout instead of using the Repository.

7. I recommend you start with the '- Common -' layout.  This layout is used to store all props that are configured the same way and mounted in the same place no matter what show you're doing.  Things like window outlines, flood lights, maybe a mega tree. 

8. Once you have the models/groups/views selected for your layout, you can click the Save button above the Layouts to save the changes to the layout.  Note that this caches the changes to memory but does not update the xLightsCompanion.xml file.  You'll still need to hit the Save button at the bottom of the window to write the changes to the XML file permanently.

8. Once you have your layout (or layouts) the way you want them, you can use the 'Commit to xLights' button to push the layout to xLights.  There are checkboxes to also include the '- Common -' layout resources along with your show specific layout.  You can also choose to overwrite existing resources (useful if you already have one of the props in xLights but it has different settings than what you're about to upload), Activate all Inactive models in xLights, and remove any models that are not part of your current Commit.

9. If the Commit works, you'll see a link in the Commit panel to open xLights with your changes.  Note that opening xLights this way will change your default show folder to your 'test' show folder.  Make sure you know where your 'real' folder is so you can change back to it when you need to.

10. Assuming all works as it should, you'll see your layout as expected.

11. After making changes in xLights (updating a prop, for instance), you can pull that change back down to xLights Companion by seleting your layout and using 'Sync Selected' on the Sync panel.  Choose the prop you want to Sync and it should overwrite your existing version in xLights Companion.  If this is a prop you have in multiple layouts, you'll need to sync it to each layout individually.


A few things to note:

- Once a prop is assigned to a layout and the layout is saved, that prop's settings are copied to that layout.  The only way to update those settings is to make a change in xLights, then sync that prop into the layout again.  If you remove that prop from your layout and save the layout, those changes are gone.  Moving the prop into the layout from the Repository will revert the prop to whatever settings the prop had when it was last sync'd to the Repository.

- This is a PowerShell script.  It's not compiled code.  It may run fast.  It may run slow.  It may hang.  It may crash.  In my testing, it's pretty responsive and rarely fails.  That said, there are definitely bugs.  All code has them.  I've squashed a bunch.  There are a bunch more.  

- If you're a scripter, feel free to update the script.  I've left decent comments in the code and I've tried to remove as much unnecessary stuff as possible.  

- The first thing we all do when we get a script is dig through the code and find stuff that's done differnet than how we would do it.  You'll see tons of unused stuff in the 'Base' scripts.  I use those as building blocks for other scripting projects.  You'll also see commented code in the main scripts.  I've gone back and forth on this project for a while.  There's old stuff that probably doesn't need to be there anymore and there's new stuff that hasn't been fleshed out yet.



This is a work in progress.  I'll fix stuff as I come across it and have time but, as of now, it's pretty much doing what I need it to do so I probably won't devote a ton more time to it this year (we're getting close to season and all).  If you want to play with it, enjoy!  If you don't, no worries.  If you break something in xLights, well, I told you not to use your production show folder.  Sorry.
