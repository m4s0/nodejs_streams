import {createWriteStream} from "fs";
import {pipeline} from "stream/promises";
import axios from "axios";
import sharp, {FitEnum} from "sharp";

export async function youtubeThumbnailToOpengraph(
  videoId: string,
  destFile: string,
  width: number,
  height: number,
  fit: keyof FitEnum): Promise<void> {
  const url = `https://i.ytimg.com/vi/${videoId}/maxresdefault.jpg`
  const image = await axios.get(url, {responseType: 'stream'})
  const transform = sharp().resize({width: width, height: height, fit: fit})
  const writeStream = createWriteStream(destFile)

  return await pipeline(image.data, transform, writeStream)
}
