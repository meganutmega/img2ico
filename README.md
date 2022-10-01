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
 1. Download the `img2ico.EXE` file located at the repository root. This executable only contains the code located in the `img2ico` directory, also in this repository.
 2. When prompted, specify the folder you wish to convert the files of to .ICO.
 3. Specify the file type you wish to convert from; PNG, JPG (*specifically* JPG), or SVG.
 4. Wait for the images to convert. If an error occurs, ensure your folder was specified correctly.
 5. An "Icons" directory containing your converted images will be made in the folder you specified.

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