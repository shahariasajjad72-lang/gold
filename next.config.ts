import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  experimental: {
    // Tree-shake large icon/animation libraries to only include what's used
    optimizePackageImports: ["lucide-react", "framer-motion"],
  },
};

export default nextConfig;
