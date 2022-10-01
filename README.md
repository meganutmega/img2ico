<p align="center"> 
    <img src="https://user-images.githubusercontent.com/38049304/193378048-5556ab90-ea0d-4781-8944-18c3a6b3afb9.png" width=750 height=250>
</p>

---

 This is a batch file that converts images into multiple-res .ICO files. This is made possible with ***ImageMagick***, by ImageMagick Studio LLC. You can visit [their website](https://imagemagick.org/script/index.php) for more information.
 
# Disclaimer
 **img2ico will only run on Windows.**
 
 You will also need ImageMagick installed to convert your files. You can download it at the above link, but img2ico will automatically download it for you and lead you through the installation process.

 This is meant as a utility tool for use primarily by the developers, but is made open-source and public for use of anyone.

 You can view the license for use of ImageMagick at [this link.](https://imagemagick.org/script/license.php)

# Usage

Download the file labeled "Source code (.zip)" located at the [releases page](https://github.com/meganutmega/img2ico/releases/). Then, using an archive program such as [WinRAR](https://www.win-rar.com/download.html?&L=0) or [7-Zip](https://www.7-zip.org/download.html), *extract* the files to a folder. Run the `img2ico.EXE` contained in there, and you're on your way!

You'll be prompted on if you want to convert a single file, or if you want to convert in bulk. Then, depending on your selection;

## Bulk

- Specify the folder your images are in.
- Specify the file type you wish to convert from; PNG, JPG (*specifically* JPG), or SVG. This is useful if you have multiple image types that you don't want converted.
- Wait for the images to convert. If an error occurs, ensure your folder was specified correctly and that your file isn't corrupt.
- An "Icons" directory containing your converted images will be made in the folder you specified.

## Single

- Specify the file you wish to convert.
- Wait for your file to convert. Should an error occur, check that your location is right and that your file isn't corrupt.
- The converted .ICO file should be in the same folder as the original.

# FAQs

<sup>More FAQs may be placed here if questions/concerns become common enough to warrant it, so keep an eye out!</sup>

### `Help! It won't let me run the .EXE!`

If the executable file refuses to run or otherwise errors, first and foremost, push an issue to us for us to look into it. Then, either attempt re-downloading and/or re-extracting the files. 

If all else fails, running the batch file directly within the `img2ico` folder should work perfectly fine.

# Changelog

## Current Version

### Beta v0.3.0

- Added ability to choose between PNG, JPG, and SVG files. Note that only JPG will work currently, *NOT* JPEG. This will be worked on soon.
- Added ability to convert singular files rather than only in bulk.

## Previous versions

### Beta v0.2.0

 - Fixed an issue regarding file names including spaces not properly converting.
 - Added error handler if conversion fails.
 - Optimized code for performance.