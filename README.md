This customizable divider inserts into a pill bottle to divide it into sections for keeping things like drill bits, nuts, bolts, or other small parts organized.

There are optional dividers you can add to each section. This helps prevent really tiny things from getting stuck or lost.

# Customization Parameters

Here is a summary of all the fields you can customize.

## `pill_bottle_lower_ID`

This is the inner diameter of your pill bottle. You can measure this by taking a piece of paper (like an index card) and gradually trimming a strip until it just fits at the bottom of your bottle.

## `pill_bottle_upper_ID`

This is the inner diameter of the pill bottle at the height you want the organizer to reach. You can probably use a pair of calipers to measure this, but trimming a piece of paper also works

## `insert_height`

This is how tall the insert will be, from the bottom of the pill bottle, measured at the outer edge of the inside of the bottle. You should measure vertically, not along the inner wall, which is slightly sloped.

## `pockets`

This is the number of organizer sections you want. A value of 6 means you'll have six sections inside your pill bottle.

## `handle_height`

This is the height of a little handle to help you insert or remove the print from the bottle. I found that this is hard to measure if you want it to extend above the rim of the bottle and still have the cap fit. You can take a drinking straw and slowly cut it down to until it fits inside your bottle at the center without buckling. Then measure the length of the straw and subtract the “insert_height” and use that value for the handle height.

## `lengths`

This is a list of the lengths of the objects that will fit inside each section. If you are keeping drill bits, just measure the length of each size drill bit.

## `labels`

This is a list of strings of the text to use to label around the bottom of the bottle insert.

## `subdividers`

Set this to True to add subdividers to each section of the insert.

# Customization instructions

1. Open the “.scad” file with OpenSCAD. 
1. Show the Customizer panel in the user interface.
1. Enter the values for your measurements.
1. Press the “Render” button and inspect the results. Make sure the text labels aren't cut off.
1. Export the render as a 3MF (recommended) or STL (meh)
1. Open the result in PrusaSlicer and away you go.

# Model Notes

Plastic pill bottles are not flat on the bottom, nor is in the inside wall perpendicular to the base.

This model has a dome shaped recess at the bottom to account for this so that the insert fits flush against deepest section of the bottle along the rim.

It has sloped sides to fit snug against the inside walls all the way to the top of the bottle so even small parts won't slide out and get stuck between the wall and insert.

The handle is not very strong because of print orientation. If the handle snaps off, you can thread a M3 bolt into the insert to make a stronger handle. Or you can just not print a handle at all and carefully use pliers to remove the insert if you have to.

The ends of the dividers are narrow to allow them to crush slightly and form a tight seal. Some pill bottles have a ridge around the inside of the bottle at the top and that will form a snug fit the divider ends.

The larger the objects your storing in your pill bottle, the less critical the dimensions are. But if you're storing tiny drill bits, you'll want to take your time and get the measurements right. You can use the cut feature in PrusaSlicer to quickly print a vertical profile to test the fit until you get things snug.

# Printing Notes

I printed these inserts on a Prusa MINI+ using Hatchbox Dark Gray Matte PLA with the 0.25mm DRAFT preset.
