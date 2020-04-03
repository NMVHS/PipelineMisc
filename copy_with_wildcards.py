import glob
import shutil
import os

def main():
    destDir = "D:\\ShawnLocal\\Archive\\Projects"
    sourceDir = "Z:\\Projects"

    ignoreExt = [".DS_Store",
                ".swatch",
                ".swatches",
                ".db",
                ".exr",
                ".sc",
                ".nk~",
                ".autosave",
                ".dpx",
                ".rs",
                ".iff"]

    totalSize = 0
    for root, dirs, files in os.walk(sourceDir):
        relDir = os.path.relpath(root, sourceDir)
        structure = os.path.join(destDir, relDir)

        for name in files:
            filePath = os.path.join(root, name)
            relFilePath = os.path.relpath(filePath, sourceDir)
            if "assets" in relFilePath:
                continue

            destFilePath = os.path.join(destDir, relFilePath)
            destFileDir = os.path.dirname(destFilePath)
            fileExt = os.path.splitext(filePath)[-1]
            fileSize = os.path.getsize(filePath)

            if fileExt in ignoreExt:
                continue

            if not os.path.isdir(destFileDir):
                os.makedirs(destFileDir)
            totalSize += fileSize
            print(filePath)
            print(fileSize)
            shutil.copy(filePath,destFilePath)

    totalSizeMb = totalSize/1024/1024
    totalSizeGB = totalSize/1024/1024/1024

    print(str(round(totalSizeGB,2)) + " GB" + " | " + str(round(totalSizeMb,2)) + " MB")
        # for name in dirs:
        #     print(os.path.join(root, name))
    # for data in glob.glob("C:\\11\\A*"):
    #     if not os.path.isdir(data):
    #         shutil.copy(data,"C:\\2\\")

if __name__ == "__main__":
    main()
