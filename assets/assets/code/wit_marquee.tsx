import React from "react";
import Link from "next/link";
import { RSVP_URL } from "./site-config";

const REPEATS = 8;

const Sparkle = () => (
  <svg
    viewBox="0 0 24 24"
    className="w-5 h-5 md:w-6 md:h-6 shrink-0 fill-white"
    aria-hidden="true"
  >
    <path d="M12 0c.6 6.6 4.8 10.8 12 12-7.2 1.2-11.4 5.4-12 12-.6-6.6-4.8-10.8-12-12C7.2 10.8 11.4 6.6 12 0z" />
  </svg>
);

const Group: React.FC<{ hidden?: boolean }> = ({ hidden }) => (
  <div className="flex shrink-0 items-center" aria-hidden={hidden || undefined}>
    {Array.from({ length: REPEATS }).map((_, i) => (
      <div key={i} className="flex items-center shrink-0">
        <span className="px-6 md:px-10 whitespace-nowrap">
          Reserve your seat now
        </span>
        <Sparkle />
      </div>
    ))}
  </div>
);

const ReserveMarquee: React.FC = () => {
  return (
    <Link
      href={RSVP_URL}
      target="_blank"
      rel="noopener noreferrer"
      aria-label="Reserve your seat for Women In Tech Summit Kenya 2026"
      className="wit-marquee relative z-10 block overflow-hidden bg-gradient-to-r from-purple-600 via-pink-500 to-purple-600 py-4 md:py-5 text-white font-space-grotesk font-extrabold uppercase tracking-wider text-lg md:text-2xl"
    >
      <style>{`
        @keyframes wit-marquee {
          from { transform: translateX(0); }
          to { transform: translateX(-50%); }
        }
        .wit-marquee-track {
          animation: wit-marquee 40s linear infinite;
        }
        .wit-marquee:hover .wit-marquee-track,
        .wit-marquee:focus-visible .wit-marquee-track {
          animation-play-state: paused;
        }
        @media (prefers-reduced-motion: reduce) {
          .wit-marquee-track { animation: none; }
        }
      `}</style>

      <div className="wit-marquee-track flex w-max">
        <Group />
        <Group hidden />
      </div>
    </Link>
  );
};

export default ReserveMarquee;