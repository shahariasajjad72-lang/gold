import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  allowedDevOrigins: ["192.168.0.134"],
  experimental: {
    // Tree-shake large icon/animation libraries to only include what's used
    optimizePackageImports: ["lucide-react", "framer-motion"],
  },
};

export default nextConfig;
