export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="ja">
      <body>
        <h1>layout</h1>
        {children}
        <h1>layout</h1>
      </body>
    </html>
  );
}
