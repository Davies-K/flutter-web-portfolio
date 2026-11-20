"use client";
import React, { useEffect, useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { ArrowRight, X } from "lucide-react";
import { RSVP_URL, SPONSOR_DECK_URL } from "./site-config";

interface Promo {
  title: string;
  meta: string;
  image: string;
  contain?: boolean;
  cta: string;
  href: string;
}

const promos: Promo[] = [
  {
    title: "Women In Tech Summit Kenya 2026",
    meta: "27th - 28th Nov, 2026",
    image: "/hero_1.png",
    cta: "Save my spot",
    href: RSVP_URL,
  },
  {
    title: "Partner with us for the summit",
    meta: "Sponsor deck available",
    image: "/wit_logo.png",
    contain: true,
    cta: "View sponsor deck",
    href: SPONSOR_DECK_URL,
  },
];

const STORAGE_KEY = "wit-promo-dismissed";
const SHOW_DELAY_MS = 1500;
const ROTATE_MS = 6000;

const PromoCard: React.FC = () => {
  const [visible, setVisible] = useState(false);
  const [index, setIndex] = useState(0);
  const [paused, setPaused] = useState(false);

  // Appear shortly after load, unless dismissed earlier in this session
  useEffect(() => {
    let dismissed = false;
    try {
      dismissed = sessionStorage.getItem(STORAGE_KEY) === "1";
    } catch {
      // storage unavailable: just show it
    }
    if (dismissed) return;

    const t = setTimeout(() => setVisible(true), SHOW_DELAY_MS);
    return () => clearTimeout(t);
  }, []);

  // Auto-rotate, paused on hover/focus and skipped for reduced motion
  useEffect(() => {
    if (!visible || paused || promos.length < 2) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    const id = setInterval(
      () => setIndex((i) => (i + 1) % promos.length),
      ROTATE_MS
    );
    return () => clearInterval(id);
  }, [visible, paused]);

  const dismiss = () => {
    setVisible(false);
    try {
      sessionStorage.setItem(STORAGE_KEY, "1");
    } catch {
      // ignore
    }
  };

  const promo = promos[index];

  return (
    <aside
      aria-label="Event announcements"
      onMouseEnter={() => setPaused(true)}
      onMouseLeave={() => setPaused(false)}
      onFocus={() => setPaused(true)}
      onBlur={() => setPaused(false)}
      className={`fixed z-30 bottom-4 left-3 right-20 sm:right-auto sm:left-6 sm:bottom-6 sm:w-[25rem] rounded-3xl border border-white/20 bg-indigo-950/90 backdrop-blur-xl shadow-2xl p-3 transition-all duration-500 motion-reduce:transition-none ${
        visible
          ? "opacity-100 translate-y-0"
          : "opacity-0 translate-y-6 invisible"
      }`}
    >
      <style>{`
        @keyframes wit-promo-in {
          from { opacity: 0; transform: translateY(6px); }
          to { opacity: 1; transform: none; }
        }
        .wit-promo-fade { animation: wit-promo-in 400ms ease-out; }
        @media (prefers-reduced-motion: reduce) {
          .wit-promo-fade { animation: none; }
        }
      `}</style>

      <button
        type="button"
        onClick={dismiss}
        aria-label="Dismiss announcement"
        className="absolute top-3 right-3 z-10 inline-flex items-center justify-center w-8 h-8 rounded-full bg-white/10 border border-white/20 text-white hover:bg-white/20 transition-colors"
      >
        <X className="w-4 h-4" />
      </button>

      <div className="flex gap-3">
        <div
          className={`relative shrink-0 w-20 sm:w-28 aspect-[3/4] rounded-2xl overflow-hidden ${
            promo.contain ? "bg-white" : "bg-white/10"
          }`}
        >
          <Image
            key={index}
            src={promo.image}
            alt=""
            fill
            sizes="112px"
            className={`wit-promo-fade ${
              promo.contain ? "object-contain p-3" : "object-cover"
            }`}
          />

          {promos.length > 1 && (
            <div className="absolute inset-x-0 bottom-2 flex justify-center">
              <div className="flex items-center rounded-full bg-black/50 backdrop-blur-sm px-1">
                {promos.map((p, i) => (
                  <button
                    key={p.title}
                    type="button"
                    onClick={() => setIndex(i)}
                    aria-label={`Show announcement ${i + 1} of ${promos.length}`}
                    aria-current={i === index}
                    className="p-1.5"
                  >
                    <span
                      className={`block h-1.5 rounded-full transition-all duration-300 ${
                        i === index ? "w-4 bg-white" : "w-1.5 bg-white/50"
                      }`}
                    />
                  </button>
                ))}
              </div>
            </div>
          )}
        </div>

        <div className="min-w-0 flex-1 flex flex-col justify-between py-1">
          <div
            key={index}
            aria-live="polite"
            className="wit-promo-fade pr-9"
          >
            <h3 className="text-white text-base sm:text-xl font-bold font-space-grotesk leading-snug">
              {promo.title}
            </h3>
            <p className="mt-1 text-sm text-pink-200">{promo.meta}</p>
          </div>

          <Link
            href={promo.href}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-3 self-start inline-flex items-center space-x-2 rounded-full bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 px-4 py-2 sm:px-5 sm:py-2.5 text-sm sm:text-base font-semibold text-white shadow-lg transition-colors"
          >
            <span>{promo.cta}</span>
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    </aside>
  );
};

export default PromoCard;