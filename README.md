# xLights Companion

This is a very basic attempt to help with layout management in xLights.  All written in PowerShell (minus the batch file to start it).  It relies on Windows Forms and is written in a scripting language so it's not the quickest, but it seems to work.

- There are a few parameters you can set within the top 30 or so lines of xLights-Main.ps1.  If you don't need to change them, you probably shouldn't.
    - One parameter in the file is strFormHeader .  Change 'Your Show Name' to whatever you'd like the header on the window to be.  I use 'Lights On Lynn'.
    - You'll also see the 'Image-ShowLogo.png' file in the folder.  Add your shows's logo to the folder using this file name and it will show up in the GUI.  I've left mine as the default cause, well, it's better than nothing.  :)

- Does this work on Mac?  No idea.  If PowerShell works, it might.  If you want to send me a Mac to try with, I'd be happy to check it out.


- Updated to reflect 2022-11-14 Changes


Quick(ish) overview:

1. Upon opening, you'll need to choose your show folder.  DO NOT POINT THIS AT YOUR PRODUCTION SHOW FOLDER!  Make a copy of the xlights_rgbeffects.xml and xlights_networks.xml files and place them in a folder (I use a folder called 'Test Layout' under the xLight Companion script folder).  xLights Companion does not (currently) mess with the networks file, but having it there will let you easily run xLights from this test folder to test the new config.

2. Once you choose your show folder, xLights Companion will then make a backup copy of your xlights_rgbeffects file into a 'Backups' subdirectory of the xLights Companion script folder.  

Note:  With the 2022/11 update, the Repository has been removed.  I found that it wasn't really very useful for anything other than the Common items, and there is already a place to store those.  You should keep a backup copy of your original xLights files if you want to ensure you can restore to pre-Companion later.  I still need to clean up a bunch of old code used for the Repository but it shouldn't hurt anything for now.

3. After opening your show folder, you'll see a list of commonly used layouts along with the functions used to Sync xLights.  Click the +/- buttons on the layout panel to add/remove layouts.  Click the ++ button to duplicate an existing layout.  

4. The easiest way to get started is to select (or create) a layout corresponding to the one (or one of the ones) currently represented in your selected xLights show folder and 'Sync All' from xLights to that layout.  This will pull all Models, Model Groups, and Views from xLights into that layout.  If you want to be more granular, you can use the 'Sync Selected' option to pull down only certain resources from xLights.

4. After the initial sync, you can either choose a different layout and sync again (either the same or different resources from xLights) or you can simply highlight the resources in xLights Companion and Copy/Move them to other layouts.

5. Once you've sync'd what you need to from xLights, you can click the layout name to view resources assigned to that layout.  You can click to highlight a resource (or Ctrl-Click/drag to highlight multiple resources), then choose a target layout and click the Copy/Move buttons to populate other layouts. Note that the resource will be identical when copied but will be assigned a new internal ID and will then be considered a completely different resource by xLights Companion.

6. I recommend you start with the '- Common -' layout.  This layout is used to store all resources that are configured the same way and mounted in the same place no matter what show you're doing.  Things like window outlines, flood lights, maybe a mega tree. Keep in mind that Model Groups might be named the same between layouts but most are generally going to contain different group members, making them different between layouts.  For instance, 'All Arches' might be the same between layouts but 'All House' likely will not.  Also note that group member names are stored as part of the group info but the individual conifguration for each member is not stored in the group.  This means that even though you may move your arches to different place for a different holiday (meaning the individual arches cannot be part of the '- Common -' layout), if you don't actually change any settings on the group or memberships of the group, you can still use 'All Arches' as a '- Common -' Model Group because the groups settings are the same.

8. Once you have the models/groups/views selected for your layout, you can click the Save button above the Layouts to save the changes to the layout.  Note that this caches the changes to memory but does not update the xLightsCompanion.xml file.  You'll still need to hit the Save button at the bottom of the window to write the changes to the XML file permanently.

8. Once you have your layout (or layouts) the way you want them, you can use the 'Commit to xLights' button to push the required layout to xLights.  There is a checkbox to also include the '- Common -' layout resources along with your show specific layout.  You can also choose to overwrite existing resources (useful if you already have one of the resources in xLights but it has different settings than what you're about to upload), Activate all Inactive models in xLights, and remove any models currently in xLights that are not part of your current Commit (for example, when changing holidays).

9. If the Commit works, you'll see a link in the Commit panel to open xLights with your changes.  Note that opening xLights this way will change your default show folder to your 'test' show folder.  Make sure you know where your 'real' folder is so you can change back to it when you need to.

10. Assuming all works as it should, you'll see your layout as expected.

11. After making changes in xLights (updating a prop, for instance), you can pull that change back down to xLights Companion by seleting your layout and using 'Update Existing' (which will update ALL resources currently assigned to that layout) or 'Sync Selected' (which will let you choose resources individually) on the Sync panel.  Choose the sync method and check/uncheck the Overwrite box(es) to update your layout.  Note that, if you are sync'ing a resource used by multiple layouts (a matrix, for instance) and you're not sync'ing it to the '- Common -' layout, you'll need perform multiple sync's to get the resource into all assigned layouts.


A few things to note:

- Once a resource is assigned to a layout and the layout is saved, that resources's settings are copied to that layout.  The only way to update those settings is to make a change in xLights, then sync that resource into the layout again.  If you remove that prop from your layout and save the layout, those changes are gone.  Moving the prop into the layout from the Repository will revert the prop to whatever settings the prop had when it was last sync'd to the Repository.

- This is a PowerShell script.  It's not compiled code.  It may run fast.  It may run slow.  It may hang.  It may crash.  In my testing, it's pretty responsive and rarely fails.  That said, there are definitely bugs.  All code has them.  I've squashed a bunch.  There are a bunch more.  

- If you're a scripter, feel free to update the script.  I've left decent comments in the code and I've tried to remove as much unnecessary stuff as possible.  

- The first thing we all do when we get a script is dig through the code and find stuff that's done differnet than how we would do it.  You'll see tons of unused stuff in the 'Base' scripts.  I use those as building blocks for other scripting projects.  You'll also see commented code in the main scripts.  I've gone back and forth on this project for a while.  There's old stuff that probably doesn't need to be there anymore and there's new stuff that hasn't been fleshed out yet.



This is a work in progress.  I'll fix stuff as I come across it and have time but, as of now, it's pretty much doing what I need it to do so I probably won't devote a ton more time to it this year (we're in season and all).  If you want to play with it, enjoy!  If you don't, no worries.  If you break something in xLights, well, I told you not to use your production show folder.  Sorry.
