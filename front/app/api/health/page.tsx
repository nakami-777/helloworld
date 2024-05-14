import { NextRequest, NextResponse } from "next/server";

export default function HealthCheckPage(req: NextRequest, res: NextResponse) {
  // return <h1>OK</h1>;
  NextResponse.json({ status: "OK" });
}
