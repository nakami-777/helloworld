"use client";

import axios from "axios";
import { useEffect, useMemo, useState } from "react";

interface Album {
  id: number;
  title: string;
  artist: string;
  price: number;
}

function Home() {
  const [albums, setAlbums] = useState<Album[]>([]);

  const fetchData = useMemo(async () => {
    const res = await axios.get(
      "http://helloworld-dev-alb-api-2082722876.ap-northeast-1.elb.amazonaws.com/v1/albums"
    );
    setAlbums(res.data);
  }, []);

  useEffect(() => {
    fetchData;
  }, [albums]);

  return (
    <div>
      {albums.map((album) => {
        return (
          <div key={album.id}>
            <h1>{album.title}</h1>
            <p>{album.artist}</p>
            <p>{album.price}</p>
          </div>
        );
      })}
    </div>
  );
}

export default Home;
