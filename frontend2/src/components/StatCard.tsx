import { cn } from "@/lib/utils";
import { type LucideIcon } from "lucide-react";

interface StatCardProps {
  title: string;
  value: string | number;
  icon: LucideIcon;
  glowClass?: string;
}

export function StatCard({ title, value, icon: Icon, glowClass }: StatCardProps) {
  return (
    <div className={cn("glass-card p-6 transition-transform hover:scale-[1.02]", glowClass)}>
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm font-medium text-muted-foreground">{title}</p>
          <p className="mt-2 text-3xl font-bold text-foreground">{value}</p>
        </div>
        <div className="rounded-xl bg-accent p-3">
          <Icon size={24} className="text-primary" />
        </div>
      </div>
    </div>
  );
}
