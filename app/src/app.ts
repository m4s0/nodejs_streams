import {youtubeThumbnailToOpengraph} from "./application/service/youtubeThumbnailToOpengraph";
import sharp from "sharp";

const DEST_FILE = 'destFile.jpg';

(async () => {
  try {
    await youtubeThumbnailToOpengraph('7Ey-Xkwn1s0', DEST_FILE, 800, 600, sharp.fit.cover)
  } catch (e: any) {
    console.log(e)
    process.exit(1)
  }

  process.exit()
})()
